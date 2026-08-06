import AetherisCards
import AetherisInsights
import AetherisNotifications
import AetherisTransfers
import Core
import AetherisAuthenticationInterface
import UIKit
import SwiftUI

extension HomeFlowCoordinator {
    private func popRoute() {
        navigation.pop()
    }

    @ViewBuilder
    var rootView: some View {
        HomeAppFactory.make(
            coreService: coreService,
            onCardTap: { cardId in
                tabBarRoutingStore.showCards(selectedCardId: cardId)
            },
            onNotificationsTap: { navigation.push(.notifications) },
            onSelectRecipient: { beneficiary in
                selectedBeneficiary = beneficiary
                navigation.push(.sendMoney)
            },
            onSeeAllRecipientsTap: { navigation.push(.beneficiaryList) },
            onNewRecipientTap: { navigation.push(.addBeneficiary) },
            onTransferTap: {
                selectedBeneficiary = BeneficiaryFixtures.defaultSelection
                navigation.push(.sendMoney)
            },
            onMoreTap: {
                withAnimation(.easeInOut(duration: 0.25)) {
                    navigation.push(.allServices)
                }
            },
            onViewReportTap: { navigation.push(.viewReport) }
        )
    }

    @ViewBuilder
    func destinationView(for route: HomeRoute) -> some View {
        switch route {
        case .card(let initialCardId):
            CardsFactory.makeEmbedded(
                coreService: coreService,
                path: $navigation.path,
                initialSelectedCardId: initialCardId,
                onFinished: { popRoute() }
            )
            .navigationBarHidden(true)

        case .sendMoney:
            TransfersFactory.makeEmbedded(
                coreService: coreService,
                identityValidation: identityValidation,
                selectedBeneficiary: $selectedBeneficiary,
                path: $navigation.path,
                onFinished: { navigation.reset() }
            )
            .navigationBarHidden(true)

        case .beneficiaryList:
            TransfersFactory.makeBeneficiaryList(
                coreService: coreService,
                onSelect: { beneficiary in
                    selectedBeneficiary = beneficiary
                    navigation.replaceCurrent(with: .sendMoney)
                },
                onBack: { popRoute() }
            )
            .navigationBarHidden(true)

        case .addBeneficiary:
            TransfersFactory.makeBeneficiarySearch(
                coreService: coreService,
                onSelect: { beneficiary in
                    selectedBeneficiary = beneficiary
                    navigation.replaceCurrent(with: .sendMoney)
                },
                onBack: { popRoute() }
            )
            .navigationBarHidden(true)

        case .notifications:
            NotificationsFactory.make(
                coreService: coreService,
                onBack: { popRoute() }
            )
            .navigationBarHidden(true)

        case .allServices:
            AllServicesFactory.make(
                onBack: { popRoute() },
                onSelect: navigateFromAllServices
            )

        case .viewReport:
            InsightsFactory.makeReport(
                coreService: coreService,
                onBack: { popRoute() }
            )
            .navigationBarHidden(true)
        }
    }

    private func navigateFromAllServices(_ route: AllServicesItem.Route) {
        switch route {
        case .transfer:
            selectedBeneficiary = BeneficiaryFixtures.defaultSelection
            navigation.replaceCurrent(with: .sendMoney)
        case .beneficiaries:
            navigation.replaceCurrent(with: .beneficiaryList)
        case .cards:
            navigation.reset()
            tabBarRoutingStore.showCards()
        case .notifications:
            navigation.replaceCurrent(with: .notifications)
        case .reports:
            navigation.replaceCurrent(with: .viewReport)
        }
    }
}
