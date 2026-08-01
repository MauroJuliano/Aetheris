import AetherisDesignSystem
import Core
import Foundation
import SwiftUI

struct CardHome: View {
    @StateObject private var viewModel: HomeCardViewModel
    @State private var selectedCardIndex: Int = 0
    @State private var isSummariesTransitioning = false
    @State private var summariesTransitionTask: Task<Void, Never>?
    let onBackAction: (() -> Void)?
    let onTransactionHistoryTap: (UUID) -> Void

    init(
        viewModel: HomeCardViewModel,
        onBackAction: (() -> Void)? = nil,
        onTransactionHistoryTap: @escaping (UUID) -> Void = { _ in }
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onBackAction = onBackAction
        self.onTransactionHistoryTap = onTransactionHistoryTap
    }

    var body: some View {
        ZStack {
            if viewModel.isLoading {
                CardHomeSkeleton()
            } else if let errorMessage = viewModel.errorMessage {
                FullScreenErrorView(
                    title: Strings.HomeCard.cardsUnavailableTitle,
                    description: errorMessage,
                    primaryButtonTitle: Strings.Common.tryAgain,
                    onPrimaryAction: {
                        Task { await viewModel.load() }
                    }
                )
            } else if viewModel.isEmpty {
                PaymentsEmptyStateView(
                    title: Strings.HomeCard.emptyTitle,
                    description: Strings.HomeCard.emptyDescription
                )
            } else {
                ScrollView(showsIndicators: false) {
                    CardSwipe(
                        cards: $viewModel.cards,
                        selectedCardIndex: $selectedCardIndex
                    )

                    HomeQuickActions(actions: viewModel.quickActions)
                        .padding(.horizontal, AppSpacing.screenHorizontal)
                        .padding(.vertical, AppSpacing.xxSmall + AppSpacing.xxxSmall)

                    summariesSection
                    .padding(.horizontal, AppSpacing.screenHorizontal)
                    .padding(.vertical, AppSpacing.xxSmall + AppSpacing.xxxSmall)
                }
                .safeAreaInset(edge: .bottom) {
                    Color.clear
                        .frame(height: AppSpacing.bottomBarClearance)
                }
            }
        }
        .appScreenBackground()
        .task { await viewModel.load() }
        .onChange(of: selectedCardIndex) { _, _ in
            refreshSummariesTransition()
        }
    }

    private func openTransactionHistory() {
        guard let cardId = currentCardId else { return }
        onTransactionHistoryTap(cardId)
    }

    private var currentCardId: UUID? {
        guard !viewModel.cards.isEmpty else { return nil }
        let safeIndex = min(max(selectedCardIndex, 0), viewModel.cards.count - 1)
        return viewModel.cards[safeIndex].id
    }

    private var currentSummaries: [FinancialSummaryModel] {
        guard let cardId = currentCardId else {
            return viewModel.summaries
        }

        let filteredSummaries = viewModel.summaries.filter { $0.cardId == cardId }
        return filteredSummaries.isEmpty ? viewModel.summaries : filteredSummaries
    }

    @ViewBuilder
    private var summariesSection: some View {
        ZStack {
            FinancialSummaryContainer(
                summaries: currentSummaries,
                onTap: openTransactionHistory
            )
            .opacity(isSummariesTransitioning ? 0 : 1)

            if isSummariesTransitioning {
                FinancialSummaryContainerSkeleton()
            }
        }
    }

    private func refreshSummariesTransition() {
        guard !viewModel.isLoading, !viewModel.isEmpty else { return }

        summariesTransitionTask?.cancel()

        summariesTransitionTask = Task { @MainActor in
            withAnimation(.easeInOut(duration: 0.12)) {
                isSummariesTransitioning = true
            }

            try? await Task.sleep(nanoseconds: 320_000_000)

            guard !Task.isCancelled else { return }

            withAnimation(.easeInOut(duration: 0.22)) {
                isSummariesTransitioning = false
            }
        }
    }
}

private struct FinancialSummaryContainerSkeleton: View {
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<4, id: \.self) { index in
                summaryRow(index: index)

                if index < 3 {
                    Divider()
                }
            }
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }

    private func summaryRow(index: Int) -> some View {
        HStack(spacing: AppSpacing.small) {
            SkeletonView(.circle)
                .frame(width: 40, height: 40)

            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                SkeletonBlock(width: index == 0 ? 120 : 150, height: 16, radius: 8)
                SkeletonBlock(width: index == 1 ? 160 : 190, height: 14, radius: 7)
                SkeletonBlock(width: index == 2 ? 64 : 74, height: 18, radius: 9)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: AppSpacing.xxSmall) {
                SkeletonBlock(width: index == 3 ? 72 : 58, height: 18, radius: 9)
                SkeletonBlock(width: index == 2 ? 52 : 44, height: 12, radius: 6)
            }
        }
        .appListCellRow(
            hasDivider: false,
            horizontalPadding: AppSpacing.medium,
            verticalPadding: AppSpacing.medium
        )
    }
}
