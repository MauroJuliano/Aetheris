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
                        onTap: openSelectedCard
                    )

                    RecipientsContainer(
                        users: viewModel.recentRecipients,
                        onSelectRecipient: onSelectRecipient,
                        onSeeAllTap: onSeeAllRecipientsTap,
                        onNewRecipientTap: onNewRecipientTap
                    )

                    QuickActions(
                        title: Strings.QuickActions.sectionTitle,
                        items: quickActionItems,
                        onItemTap: { item in
                            switch item.id {
                            case Self.sendQuickActionId:
                                onTransferTap()

                            case Self.requestQuickActionId:
                                onRequestMoneyTap()

                            default:
                                onMoreTap()
                            }
                        }
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

    private func openSelectedCard() {
        guard let selectedCardId else { return }
        onCardTap(selectedCardId)
    }

    private static let sendQuickActionId = "send"
    private static let requestQuickActionId = "request"
    private static let moreQuickActionId = "more_services"

    private var quickActionItems: [QuickActionItem] {
        let sendAction = viewModel.quickActions.first { $0.route == .sendMoney }
        let requestAction = viewModel.quickActions.first { $0.route == .requestMoney }

        return [
            .init(
                id: Self.sendQuickActionId,
                title: sendAction?.title ?? Strings.QuickActions.sendTitle,
                subtitle: sendAction?.subtitle ?? Strings.QuickActions.transferSubtitle,
                icon: sendAction?.icon ?? "paperplane.fill"
            ),
            .init(
                id: Self.requestQuickActionId,
                title: requestAction?.title ?? Strings.QuickActions.requestTitle,
                subtitle: requestAction?.subtitle ?? Strings.QuickActions.requestSubtitle,
                icon: requestAction?.icon ?? "arrow.down"
            ),
            .init(
                id: Self.moreQuickActionId,
                title: Strings.QuickActions.moreTitle,
                subtitle: Strings.QuickActions.moreSubtitle,
                icon: "ellipsis"
            )
        ]
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
