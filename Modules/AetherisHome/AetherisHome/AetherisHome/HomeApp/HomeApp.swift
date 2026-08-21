import AetherisDesignSystem
import AetherisInsights
import Core
import Foundation
import SwiftUI

struct HomeApp: View {
    @StateObject private var viewModel: HomeAppViewModel
    @State private var selectedCardIndex: Int = 0
    let onCardTap: (UUID) -> Void
    let onNotificationsTap: () -> Void
    let onSelectRecipient: (Beneficiary) -> Void
    let onSeeAllRecipientsTap: () -> Void
    let onNewRecipientTap: () -> Void
    let onTransferTap: () -> Void
    let onRequestMoneyTap: () -> Void
    let onMoreTap: () -> Void
    let onViewReportTap: () -> Void

    init(
        viewModel: HomeAppViewModel,
        onCardTap: @escaping (UUID) -> Void,
        onNotificationsTap: @escaping () -> Void,
        onSelectRecipient: @escaping (Beneficiary) -> Void,
        onSeeAllRecipientsTap: @escaping () -> Void,
        onNewRecipientTap: @escaping () -> Void,
        onTransferTap: @escaping () -> Void,
        onRequestMoneyTap: @escaping () -> Void,
        onMoreTap: @escaping () -> Void,
        onViewReportTap: @escaping () -> Void
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onCardTap = onCardTap
        self.onNotificationsTap = onNotificationsTap
        self.onSelectRecipient = onSelectRecipient
        self.onSeeAllRecipientsTap = onSeeAllRecipientsTap
        self.onNewRecipientTap = onNewRecipientTap
        self.onTransferTap = onTransferTap
        self.onRequestMoneyTap = onRequestMoneyTap
        self.onMoreTap = onMoreTap
        self.onViewReportTap = onViewReportTap
    }

    var body: some View {
        ZStack {
            Image("login-background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            if let errorMessage = viewModel.errorMessage {
                FeedbackView(
                    title: Strings.HomeApp.homeUnavailableTitle,
                    description: errorMessage,
                    primaryButtonTitle: Strings.Common.tryAgain,
                    onPrimaryAction: {
                        Task { await viewModel.load() }
                    }
                )
            } else if viewModel.isEmpty {
                AppEmptyStateView(
                    title: Strings.HomeApp.noDashboardDataTitle,
                    description: Strings.HomeApp.emptyDescription
                )
            } else {
                ScrollView(showsIndicators: false) {
                    NavBar(
                        shouldPresentNotifications: viewModel.hasUnreadNotifications,
                        model: .init(
                            firstText: Strings.HomeApp.welcomePrefix,
                            secondText: viewModel.userFirstName,
                            hasInitialSpace: false
                        ),
                        onRightButtonAction: onNotificationsTap
                    )
                    .toSkeleton(enable: viewModel.isLoading)

                    BalanceView()
                        .toSkeleton(enable: viewModel.isLoading)

                    CardSwipe(
                        cards: $viewModel.cards,
                        selectedCardIndex: $selectedCardIndex,
                        onTap: openSelectedCard
                    )
                    .toSkeleton(enable: viewModel.isLoading)

                    RecipientsContainer(
                        title: Strings.Recipients.title,
                        seeAllTitle: Strings.Recipients.seeAll,
                        newRecipientTitle: Strings.Recipients.newRecipient,
                        recipients: viewModel.recipientItems,
                        onSelectRecipient: { recipient in
                            guard let selectedRecipient = viewModel.recipient(for: recipient.id) else { return }
                            onSelectRecipient(selectedRecipient)
                        },
                        onSeeAllTap: onSeeAllRecipientsTap,
                        onNewRecipientTap: onNewRecipientTap
                    )
                    .toSkeleton(enable: viewModel.isLoading)

                    QuickActions(
                        title: Strings.QuickActions.sectionTitle,
                        items: viewModel.quickActionItems,
                        onItemTap: { item in
                            switch viewModel.quickActionDestination(for: item.id) {
                            case .transfer:
                                onTransferTap()

                            case .request:
                                onRequestMoneyTap()

                            case .more:
                                onMoreTap()
                            }
                        }
                    )
                    .toSkeleton(enable: viewModel.isLoading)

                    spendingAnalyticsCard
                }
                .padding(.top, AppSpacing.formTop)
                .padding(.horizontal, AppSpacing.screenHorizontal)
                .safeAreaInset(edge: .bottom) {
                    Color.clear
                        .frame(height: AppSpacing.bottomBarClearance)
                }
            }
        }
        .task { await viewModel.loadIfNeeded() }
        .accessibilityIdentifier("home.screen")
    }

    private func openSelectedCard() {
        guard let selectedCardId else { return }
        onCardTap(selectedCardId)
    }

    private var spendingAnalyticsCard: some View {
        let spending = viewModel.spendingAnalyticsCardModel

        return AnalyticsCard(
            title: spending.title,
            totalTitle: spending.totalTitle,
            changeTitle: spending.changeTitle,
            comparisonTitle: spending.comparisonTitle,
            viewReportTitle: Strings.SpendingChart.viewReport,
            onViewReportTap: onViewReportTap
        ) {
            SpendingLineChart()
        } footerContent: {
            AnalyticsCategorySummary(items: spending.categories)
        }
        .toSkeleton(enable: viewModel.isLoading)
    }

    private var selectedCardId: UUID? {
        guard !viewModel.cards.isEmpty else { return nil }
        let safeIndex = min(max(selectedCardIndex, 0), viewModel.cards.count - 1)
        return viewModel.cards[safeIndex].id
    }
}

#Preview {
    HomeApp(
        viewModel: HomeAppViewModel(
            service: HomeAppService(
                coreService: DemoCoreService(delay: 0)
            )
        ),
        onCardTap: { _ in },
        onNotificationsTap: {},
        onSelectRecipient: { _ in },
        onSeeAllRecipientsTap: {},
        onNewRecipientTap: {},
        onTransferTap: {},
        onRequestMoneyTap: {},
        onMoreTap: {},
        onViewReportTap: {}
    )
}
