import AetherisDesignSystem
import AetherisInsights
import SwiftUI

struct HomeApp: View {
    @StateObject private var viewModel: HomeAppViewModel
    @State private var selectedCardIndex: Int = 0
    let onCardTap: () -> Void
    let onNotificationsTap: () -> Void
    let onSelectRecipient: (Beneficiary) -> Void
    let onSeeAllRecipientsTap: () -> Void
    let onNewRecipientTap: () -> Void
    let onTransferTap: () -> Void
    let onMoreTap: () -> Void
    let onViewReportTap: () -> Void

    init(
        viewModel: HomeAppViewModel,
        onCardTap: @escaping () -> Void,
        onNotificationsTap: @escaping () -> Void,
        onSelectRecipient: @escaping (Beneficiary) -> Void,
        onSeeAllRecipientsTap: @escaping () -> Void,
        onNewRecipientTap: @escaping () -> Void,
        onTransferTap: @escaping () -> Void,
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
        self.onMoreTap = onMoreTap
        self.onViewReportTap = onViewReportTap
    }

    var body: some View {
        ZStack {
            Image("login-background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            if viewModel.isLoading {
                HomeAppSkeleton()
            } else if let errorMessage = viewModel.errorMessage {
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

                    BalanceView()

                    CardSwipe(
                        cards: $viewModel.cards,
                        selectedCardIndex: $selectedCardIndex,
                        onTap: onCardTap
                    )

                    RecipientsContainer(
                        onSelectRecipient: onSelectRecipient,
                        onSeeAllTap: onSeeAllRecipientsTap,
                        onNewRecipientTap: onNewRecipientTap
                    )

                    QuickActions(
                        onTransferTap: onTransferTap,
                        onMoreTap: onMoreTap
                    )

                    SpendingThisMonthView(
                        onViewReportTap: onViewReportTap
                    )
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
}
