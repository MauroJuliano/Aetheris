import AetherisDesignSystem
import Core
import Foundation
import SwiftUI

struct CardHome: View {
    @StateObject private var viewModel: HomeCardViewModel
    @StateObject private var presentation = CardHomePresentationModel()
    private let initialSelectedCardId: UUID?
    private let selectedCardRequestId: UUID?
    private let onSelectedCardRequestApplied: () -> Void
    let onBackAction: (() -> Void)?
    let onTransactionHistoryTap: (UUID) -> Void
    let onVirtualCardTap: (UUID) -> Void
    let onInvoiceTap: (UUID) -> Void
    let onDueDateTap: (UUID) -> Void
    let onCardLockTap: (UUID) -> Void
    let onSendMoneyTap: () -> Void
    let onRequestMoneyTap: () -> Void
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
        onCardLockTap: @escaping (UUID) -> Void = { _ in },
        onSendMoneyTap: @escaping () -> Void = {},
        onRequestMoneyTap: @escaping () -> Void = {},
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
        self.onSendMoneyTap = onSendMoneyTap
        self.onRequestMoneyTap = onRequestMoneyTap
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
                if let errorMessage = viewModel.errorMessage {
                    FeedbackView(
                        title: Strings.HomeCard.cardsUnavailableTitle,
                        description: errorMessage,
                        primaryButtonTitle: Strings.Common.tryAgain,
                        onPrimaryAction: {
                            Task { await viewModel.load() }
                        }
                    )
                } else if viewModel.isEmpty && !viewModel.isLoading {
                    AppEmptyStateView(
                        title: Strings.HomeCard.emptyTitle,
                        description: Strings.HomeCard.emptyDescription
                    )
                } else {
                    cardHomeContent
                }
            }
        }
        .safeAreaPadding(.top, AppSpacing.formTop)
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
        .onChange(of: presentation.selectedCardIndex) { _, _ in
            presentation.refreshContentTransition(
                isLoading: viewModel.isLoading,
                isEmpty: viewModel.isEmpty
            )
        }
        .accessibilityIdentifier("cards.screen")
    }

    private var cardHomeContent: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                cardSwipeSection

                cardDetailsSection
                    .padding(.horizontal, AppSpacing.screenHorizontal)
                    .padding(.vertical, AppSpacing.xxSmall + AppSpacing.xxxSmall)

                CompactQuickActions(
                    items: currentQuickActionItems,
                    onItemTap: { item in
                        guard let action = currentQuickActions.first(where: { $0.id == item.id }) else { return }
                        handleQuickActionTap(action)
                    }
                )
                .toSkeleton(enable: viewModel.isLoading)
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

    private var cardSwipeSection: some View {
        CardSwipe(
            cards: $viewModel.cards,
            selectedCardIndex: $presentation.selectedCardIndex
        )
        .toSkeleton(enable: viewModel.isLoading)
        .padding(.horizontal, AppSpacing.screenHorizontal)
        .padding(.top, AppSpacing.xSmall)
    }

    private var cardDetailsSection: some View {
        CardInformationContainer(
            model: currentCardDetails ?? .placeholder(cardId: currentCardId),
            onInvoiceTap: {
                guard let cardId = currentCardId else { return }
                onInvoiceTap(cardId)
            },
            onDueDateTap: {
                guard let cardId = currentCardId else { return }
                onDueDateTap(cardId)
            }
        )
        .toSkeleton(enable: viewModel.isLoading || presentation.isCardDetailsTransitioning)
    }

    private var summariesSection: some View {
        FinancialSummaryContainer(
            summaries: currentSummaries,
            title: Strings.VirtualCard.recentTransactions,
            actionTitle: Strings.VirtualCard.seeAll,
            onTap: openTransactionHistory,
            onActionTap: openTransactionHistory
        )
        .toSkeleton(enable: viewModel.isLoading || presentation.isSummariesTransitioning)
    }

    private func openTransactionHistory() {
        guard let cardId = currentCardId else { return }
        onTransactionHistoryTap(cardId)
    }

    private var currentCardId: UUID? {
        viewModel.cardId(at: presentation.selectedCardIndex)
    }

    private func applyInitialSelectedCardIfNeeded() {
        presentation.applyInitialSelection(
            cardID: initialSelectedCardId,
            cards: viewModel.cards
        )
    }

    private func applySelectedCardRequestIfNeeded() {
        if presentation.applyRequestedSelection(
            cardID: selectedCardRequestId,
            cards: viewModel.cards
        ) {
            onSelectedCardRequestApplied()
        }
    }

    private var currentCardDetails: CardDetailsModel? {
        viewModel.cardDetails(at: presentation.selectedCardIndex)
    }

    private var currentSummaries: [FinancialSummaryModel] {
        viewModel.summaries(at: presentation.selectedCardIndex)
    }

    private var currentQuickActions: [CardOptions] {
        viewModel.quickActions(at: presentation.selectedCardIndex)
    }

    private var currentQuickActionItems: [CompactQuickActionItem] {
        viewModel.quickActionItems(at: presentation.selectedCardIndex)
    }

    private func handleQuickActionTap(_ option: CardOptions) {
        guard let destination = viewModel.quickActionDestination(
            for: option,
            at: presentation.selectedCardIndex
        ) else { return }

        switch destination {
        case .sendMoney:
            onSendMoneyTap()
        case .requestMoney:
            onRequestMoneyTap()
        case .virtualCard(let cardId):
            onVirtualCardTap(cardId)
        case .cardLock(let cardId):
            onCardLockTap(cardId)
        case .custom(let option):
            onQuickActionTap(option)
        }
    }

}

#Preview("Card Home") {
    CardHome(
        viewModel: HomeCardViewModel(
            service: HomeCardService(
                coreService: DemoCoreService(delay: 0)
            )
        )
    )
}
