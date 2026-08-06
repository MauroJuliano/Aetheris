import AetherisDesignSystem
import Core
import Foundation
import SwiftUI

struct CardHome: View {
    @StateObject private var viewModel: HomeCardViewModel
    @State private var selectedCardIndex: Int = 0
    @State private var didApplyInitialSelectedCard = false
    @State private var isCardDetailsTransitioning = false
    @State private var cardDetailsTransitionTask: Task<Void, Never>?
    @State private var isSummariesTransitioning = false
    @State private var summariesTransitionTask: Task<Void, Never>?
    private let initialSelectedCardId: UUID?
    private let selectedCardRequestId: UUID?
    private let onSelectedCardRequestApplied: () -> Void
    let onBackAction: (() -> Void)?
    let onTransactionHistoryTap: (UUID) -> Void
    let onVirtualCardTap: (UUID) -> Void
    let onInvoiceTap: (UUID) -> Void
    let onDueDateTap: (UUID) -> Void
    let onCardLockTap: (UUID, Bool) -> Void
    let onQuickActionTap: (CardOptions) -> Void

    init(
        viewModel: HomeCardViewModel,
        initialSelectedCardId: UUID? = nil,
        selectedCardRequestId: UUID? = nil,
        onSelectedCardRequestApplied: @escaping () -> Void = {},
        onBackAction: (() -> Void)? = nil,
        onTransactionHistoryTap: @escaping (UUID) -> Void = { _ in },
        onVirtualCardTap: @escaping (UUID) -> Void = { _ in },
        onInvoiceTap: @escaping (UUID) -> Void = { _ in },
        onDueDateTap: @escaping (UUID) -> Void = { _ in },
        onCardLockTap: @escaping (UUID, Bool) -> Void = { _, _ in },
        onQuickActionTap: @escaping (CardOptions) -> Void = { _ in }
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.initialSelectedCardId = initialSelectedCardId
        self.selectedCardRequestId = selectedCardRequestId
        self.onSelectedCardRequestApplied = onSelectedCardRequestApplied
        self.onBackAction = onBackAction
        self.onTransactionHistoryTap = onTransactionHistoryTap
        self.onVirtualCardTap = onVirtualCardTap
        self.onInvoiceTap = onInvoiceTap
        self.onDueDateTap = onDueDateTap
        self.onCardLockTap = onCardLockTap
        self.onQuickActionTap = onQuickActionTap
    }

    var body: some View {
        VStack(spacing: 0) {
                NavBar(
                    hasNotifications: false,
                    hasBackButton: false,
                    model: .init(
                        firstText: Strings.CardHome.title,
                        hasInitialSpace: false
                    ),
                    onBack: onBackAction
                )
                .padding(.horizontal, AppSpacing.screenHorizontal)
                .padding(.bottom)

            ZStack {
                if viewModel.isLoading {
                    CardHomeSkeleton()
                } else if let errorMessage = viewModel.errorMessage {
                    FeedbackView(
                        title: Strings.HomeCard.cardsUnavailableTitle,
                        description: errorMessage,
                        primaryButtonTitle: Strings.Common.tryAgain,
                        onPrimaryAction: {
                            Task { await viewModel.load() }
                        }
                    )
                } else if viewModel.isEmpty {
                    AppEmptyStateView(
                        title: Strings.HomeCard.emptyTitle,
                        description: Strings.HomeCard.emptyDescription
                    )
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 0) {
                            CardSwipe(
                                cards: $viewModel.cards,
                                selectedCardIndex: $selectedCardIndex
                            )

                            cardDetailsSection
                                .padding(.horizontal, AppSpacing.screenHorizontal)
                                .padding(.vertical, AppSpacing.xxSmall + AppSpacing.xxxSmall)

                            HomeQuickActions(
                                actions: viewModel.quickActions,
                                onAction: onQuickActionTap
                            )
                            .padding(.horizontal, AppSpacing.screenHorizontal)
                            .padding(.vertical, AppSpacing.xxSmall + AppSpacing.xxxSmall)

                            summariesSection
                                .padding(.horizontal, AppSpacing.screenHorizontal)
                                .padding(.vertical, AppSpacing.xxSmall + AppSpacing.xxxSmall)
                        }
                    }
                    .safeAreaInset(edge: .bottom) {
                        Color.clear
                            .frame(height: AppSpacing.bottomBarClearance)
                    }
                }
            }
        }
        .appScreenBackground()
        .task {
            await viewModel.loadIfNeeded()
            applyInitialSelectedCardIfNeeded()
            applySelectedCardRequestIfNeeded()
        }
        .onChange(of: viewModel.cards) { _, _ in
            applyInitialSelectedCardIfNeeded()
            applySelectedCardRequestIfNeeded()
        }
        .onChange(of: selectedCardRequestId) { _, _ in
            applySelectedCardRequestIfNeeded()
        }
        .onChange(of: selectedCardIndex) { _, _ in
            refreshCardContentTransition()
        }
        .accessibilityIdentifier("cards.screen")
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

    private func applyInitialSelectedCardIfNeeded() {
        guard !didApplyInitialSelectedCard,
              let initialSelectedCardId,
              let initialSelectedCardIndex = viewModel.cards.firstIndex(where: { $0.id == initialSelectedCardId }) else {
            return
        }

        selectedCardIndex = initialSelectedCardIndex
        didApplyInitialSelectedCard = true
    }

    private func applySelectedCardRequestIfNeeded() {
        guard let selectedCardRequestId,
              let selectedCardRequestIndex = viewModel.cards.firstIndex(where: { $0.id == selectedCardRequestId }) else {
            return
        }

        selectedCardIndex = selectedCardRequestIndex
        onSelectedCardRequestApplied()
    }

    private var currentCardDetails: CardDetailsModel? {
        guard let cardId = currentCardId else {
            return nil
        }

        return viewModel.cardDetails.first { $0.cardId == cardId }
    }

    private var currentSummaries: [FinancialSummaryModel] {
        guard let cardId = currentCardId else {
            return viewModel.summaries
        }

        let filteredSummaries = viewModel.summaries.filter { $0.cardId == cardId }
        return filteredSummaries.isEmpty ? viewModel.summaries : filteredSummaries
    }

    @ViewBuilder
    private var cardDetailsSection: some View {
        ZStack {
            if let details = currentCardDetails {
                CardInformationContainer(
                    model: details,
                    onInvoiceTap: {
                        guard let cardId = currentCardId else { return }
                        onInvoiceTap(cardId)
                    },
                    onDueDateTap: {
                        guard let cardId = currentCardId else { return }
                        onDueDateTap(cardId)
                    },
                    onVirtualCardTap: {
                        guard let cardId = currentCardId else { return }
                        onVirtualCardTap(cardId)
                    },
                    onLockTap: {
                        guard let cardId = currentCardId else { return }
                        onCardLockTap(cardId, !details.isBlocked)
                    }
                )
                .opacity(isCardDetailsTransitioning ? 0 : 1)
            }

            if isCardDetailsTransitioning {
                CardInformationContainerSkeleton()
            }
        }
    }

    @ViewBuilder
    private var summariesSection: some View {
        ZStack {
            FinancialSummaryContainer(
                summaries: currentSummaries,
                title: Strings.VirtualCard.recentTransactions,
                actionTitle: Strings.VirtualCard.seeAll,
                onTap: openTransactionHistory,
                onActionTap: openTransactionHistory
            )
            .opacity(isSummariesTransitioning ? 0 : 1)

            if isSummariesTransitioning {
                FinancialSummaryContainerSkeleton()
            }
        }
    }

    private func refreshCardContentTransition() {
        guard !viewModel.isLoading, !viewModel.isEmpty else { return }

        refreshCardDetailsTransition()
        refreshSummariesTransition()
    }

    private func refreshCardDetailsTransition() {
        cardDetailsTransitionTask?.cancel()

        cardDetailsTransitionTask = Task { @MainActor in
            withAnimation(.easeInOut(duration: 0.12)) {
                isCardDetailsTransitioning = true
            }

            try? await Task.sleep(nanoseconds: 320_000_000)

            guard !Task.isCancelled else { return }

            withAnimation(.easeInOut(duration: 0.22)) {
                isCardDetailsTransitioning = false
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

private struct CardInformationContainerSkeleton: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: AppSpacing.medium) {
                summaryColumn

                Divider()
                    .frame(height: 104)

                summaryColumn
            }
            .padding(AppSpacing.medium)

            Divider()
                .padding(.horizontal, AppSpacing.medium)

            HStack(spacing: AppSpacing.small) {
                SkeletonView(.circle)
                    .frame(width: 44, height: 44)

                VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                    SkeletonBlock(width: 90, height: 14, radius: 7)
                    SkeletonBlock(width: 110, height: 16, radius: 8)
                }

                Spacer()
            }
            .padding(AppSpacing.medium)

            Divider()
                .padding(.horizontal, AppSpacing.medium)

            HStack(spacing: AppSpacing.large) {
                managementAction
                managementAction
            }
            .padding(AppSpacing.medium)
        }
        .appCardSurface()
    }

    private var summaryColumn: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
            SkeletonBlock(width: 120, height: 14, radius: 7)
            SkeletonBlock(width: 100, height: 22, radius: 9)
            SkeletonBlock(width: 130, height: 8, radius: 4)
            SkeletonBlock(width: 90, height: 14, radius: 7)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var managementAction: some View {
        VStack(spacing: AppSpacing.xSmall) {
            SkeletonView(.circle)
                .frame(
                    width: AppComponentMetrics.mediumCircleSize,
                    height: AppComponentMetrics.mediumCircleSize
                )

            SkeletonBlock(width: 90, height: 14, radius: 7)
        }
        .frame(maxWidth: .infinity)
    }
}
