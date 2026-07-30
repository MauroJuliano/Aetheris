import AetherisDesignSystem
import Core
import Foundation
import SwiftUI

struct CardHome: View {
    @StateObject private var viewModel: HomeCardViewModel
    @State private var selectedCardIndex: Int = 0
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
                    NavBar(
                        hasBackButton: onBackAction != nil,
                        model: .init(
                            firstText: Strings.CardHome.title,
                            hasInitialSpace: false
                        ),
                        onBack: onBackAction
                    )
                    .padding(.horizontal, AppSpacing.screenHorizontal)

                    CardSwipe(
                        cards: $viewModel.cards,
                        selectedCardIndex: $selectedCardIndex
                    )

                    HomeQuickActions(actions: viewModel.quickActions)
                        .padding(.horizontal, AppSpacing.screenHorizontal)
                        .padding(.vertical, AppSpacing.xxSmall + AppSpacing.xxxSmall)

                    FinancialSummaryContainer(
                        summaries: viewModel.summaries,
                        onTap: openTransactionHistory
                    )
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
}
