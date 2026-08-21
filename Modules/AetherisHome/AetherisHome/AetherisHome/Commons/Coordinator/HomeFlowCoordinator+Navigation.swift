import AetherisCards
import AetherisInsightsInterface
import AetherisNotificationsInterface
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
            onNotificationsTap: {
                apply(
                    HomeFlowCoordinatorRouter.notificationsTapped()
                )
            },
            onSelectRecipient: { beneficiary in
                navigation.push(.beneficiaryDetails(beneficiary.id))
            },
            onSeeAllRecipientsTap: { navigation.push(.beneficiaryList) },
            onNewRecipientTap: { navigation.push(.addBeneficiary) },
            onTransferTap: {
                selectedBeneficiary = nil
                navigation.push(.sendMoney)
            },
            onRequestMoneyTap: {
                navigation.push(.requestMoney)
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
                onFinished: { popRoute() },
                onSendMoneyTap: {
                    selectedBeneficiary = nil
                    navigation.push(.sendMoney)
                },
                onRequestMoneyTap: {
                    navigation.push(.requestMoney)
                }
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

        case .requestMoney:
            TransfersFactory.makeRequestMoneyWithContactPicker(
                coreService: coreService,
                path: $navigation.path,
                onBack: { popRoute() },
                onFinished: { popRoute() }
            )
            .navigationBarHidden(true)

        case .beneficiaryDetails(let beneficiaryId):
            TransfersFactory.makeBeneficiaryDetails(
                coreService: coreService,
                beneficiaryId: beneficiaryId,
                path: $navigation.path,
                onBack: { popRoute() },
                onNotificationsTap: { navigation.push(.notifications) },
                onTransferTap: { beneficiary in
                    selectedBeneficiary = beneficiary
                    navigation.push(.sendMoney)
                },
                onBeneficiaryRemoved: { popRoute() }
            )
            .navigationBarHidden(true)

        case .beneficiaryList:
            TransfersFactory.makeBeneficiaryList(
                coreService: coreService,
                onSelect: { beneficiary in
                    navigation.replaceCurrent(with: .beneficiaryDetails(beneficiary.id))
                },
                onBack: { popRoute() }
            )
            .navigationBarHidden(true)

        case .addBeneficiary:
            TransfersFactory.makeBeneficiarySearch(
                coreService: coreService,
                onSelect: { beneficiary in
                    navigation.replaceCurrent(with: .beneficiaryDetails(beneficiary.id))
                },
                onBack: { popRoute() }
            )
            .navigationBarHidden(true)

        case .notifications:
            notificationsFactory.make(
                onBack: { popRoute() }
            )
            .navigationBarHidden(true)

        case .allServices:
            AllServicesFactory.make(
                coreService: coreService,
                onBack: { popRoute() },
                onSelect: navigateFromAllServices
            )

        case .viewReport:
            insightsFactory.makeReport(
                onBack: { popRoute() }
            )
            .navigationBarHidden(true)
        }
    }

    private func navigateFromAllServices(_ route: AllServicesItem.Route) {
        apply(
            HomeFlowCoordinatorRouter.allServicesSelected(route)
        )
    }

    private func apply(
        _ commands: [HomeFlowCoordinatorCommand]
    ) {
        for command in commands {
            switch command {
            case .clearSelectedBeneficiary:
                selectedBeneficiary = nil

            case .push(let homeRoute):
                navigation.push(homeRoute)

            case .replace(let homeRoute):
                navigation.replaceCurrent(with: homeRoute)

            case .showCards(let selectedCardId):
                navigation.reset()
                tabBarRoutingStore.showCards(selectedCardId: selectedCardId)
            }
        }
    }
}
