import Core
import PaymentsInterface
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
            onCardTap: { navigation.push(.card) },
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
        case .card:
            HomeCardFactory.make(
                coreService: coreService,
                onBackAction: { popRoute() },
                onTransactionHistoryTap: { cardId in navigation.push(.transactionHistory(cardId)) }
            )
            .navigationBarHidden(true)

        case .transactionHistory(let cardId):
            TransactionHistoryFactory.make(
                coreService: coreService,
                cardId: cardId,
                onBack: { popRoute() }
            )

        case .sendMoney:
            SendMoneyFactory.make(
                coreService: coreService,
                selectedBeneficiary: $selectedBeneficiary,
                onBackAction: { popRoute() },
                onChangeBeneficiary: {
                    navigation.push(.sendMoneyBeneficiaryList)
                },
                onContinue: { receipt in
                    navigation.push(.sendMoneyPin(receipt))
                }
            )
            .navigationBarHidden(true)

        case .beneficiaryList:
            BeneficiaryListFactory.make(
                coreService: coreService,
                onSelect: { beneficiary in
                    selectedBeneficiary = beneficiary
                    replaceCurrentRoute(with: .sendMoney)
                },
                onBack: { popRoute() }
            )
            .navigationBarHidden(true)

        case .sendMoneyBeneficiaryList:
            BeneficiaryListFactory.make(
                coreService: coreService,
                onSelect: { beneficiary in
                    selectedBeneficiary = beneficiary
                    popRoute()
                },
                onBack: { popRoute() }
            )
            .navigationBarHidden(true)

        case .sendMoneyPin(let draft):
            TransferPinFactory.make(
                coreService: coreService,
                draft: draft,
                onBack: { popRoute() },
                onAuthorized: { authorization in
                    navigation.push(.sendMoneyProcessing(.init(
                        draft: draft,
                        authorization: authorization,
                        idempotencyKey: UUID().uuidString
                    )))
                },
                onValidationFailed: {
                    navigation.returnToSendMoney()
                }
            )
            .navigationBarHidden(true)

        case .sendMoneyProcessing(let submission):
            TransferProcessingFactory.make(
                coreService: coreService,
                submission: submission,
                onCompleted: { receipt in
                    replaceCurrentRoute(with: .sendMoneySuccess(receipt))
                },
                onTryLater: {
                    navigation.returnToSendMoney()
                }
            )
            .navigationBarHidden(true)

        case .sendMoneySuccess(let receipt):
            TransferSuccessFactory.make(
                model: receipt,
                onBack: { navigation.reset() },
                onDone: {
                    navigation.reset()
                },
                onNewTransfer: {
                    navigation.reset()
                },
                onCopyReference: { reference in
                    UIPasteboard.general.string = reference
                }
            )
            .navigationBarHidden(true)

        case .addBeneficiary:
            BeneficiaryAddFactory.make(
                coreService: coreService,
                onBack: { popRoute() },
                onComplete: { beneficiary in
                    selectedBeneficiary = beneficiary
                    replaceCurrentRoute(with: .sendMoney)
                }
            )
            .navigationBarHidden(true)

        case .notifications:
            NotificationsCentreFactory.make(
                coreService: coreService,
                onBack: { popRoute() }
            )
            .navigationBarHidden(true)

        case .allServices:
            AllServicesFactory.make(
                onBack: { popRoute() }
            )

        case .insurance:
            InsuranceOnboardingFactory.make(coreService: coreService)
                .navigationBarHidden(true)

        case .viewReport:
            ViewReportFlowCoordinator(
                coreService: coreService,
                onBack: { popRoute() }
            )
            .navigationBarHidden(true)
        }
    }

    private func replaceCurrentRoute(with route: HomeRoute) {
        navigation.replaceCurrent(with: route)
    }
}
