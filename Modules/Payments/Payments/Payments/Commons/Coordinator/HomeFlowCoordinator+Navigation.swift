import Core
import PaymentsInterface
import UIKit
import SwiftUI

extension HomeFlowCoordinator {
    private func popRoute() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    @ViewBuilder
    var rootView: some View {
        HomeAppFactory.make(
            coreService: coreService,
            onCardTap: { path.append(.card) },
            onNotificationsTap: { path.append(.notifications) },
            onSelectRecipient: { beneficiary in
                selectedBeneficiary = beneficiary
                path.append(.sendMoney)
            },
            onSeeAllRecipientsTap: { path.append(.beneficiaryList) },
            onNewRecipientTap: { path.append(.addBeneficiary) },
            onTransferTap: {
                selectedBeneficiary = .defaultSelection
                path.append(.sendMoney)
            },
            onMoreTap: {
                withAnimation(.easeInOut(duration: 0.25)) {
                    path.append(.allServices)
                }
            },
            onViewReportTap: { path.append(.viewReport) }
        )
    }

    @ViewBuilder
    func destinationView(for route: HomeRoute) -> some View {
        switch route {
        case .card:
            HomeCardFactory.make(
                coreService: coreService,
                onBackAction: { popRoute() },
                onTransactionHistoryTap: { path.append(.transactionHistory) }
            )
            .navigationBarHidden(true)

        case .transactionHistory:
            TransactionHistoryFactory.make(
                coreService: coreService,
                onBack: { popRoute() }
            )

        case .sendMoney:
            SendMoneyFactory.make(
                selectedBeneficiary: $selectedBeneficiary,
                onBackAction: { popRoute() },
                onChangeBeneficiary: {
                    path.append(.sendMoneyBeneficiaryList)
                },
                onContinue: { receipt in
                    path.append(.sendMoneyPin(receipt))
                }
            )
            .navigationBarHidden(true)

        case .beneficiaryList:
            BeneficiaryListFactory.make(
                onSelect: { beneficiary in
                    selectedBeneficiary = beneficiary
                    replaceCurrentRoute(with: .sendMoney)
                },
                onBack: { popRoute() }
            )
            .navigationBarHidden(true)

        case .sendMoneyBeneficiaryList:
            BeneficiaryListFactory.make(
                onSelect: { beneficiary in
                    selectedBeneficiary = beneficiary
                    popRoute()
                },
                onBack: { popRoute() }
            )
            .navigationBarHidden(true)

        case .sendMoneyPin(let receipt):
            TransferPinFactory.make(
                receipt: receipt,
                onBack: { popRoute() },
                onValidPin: {
                    path.append(.sendMoneyProcessing(receipt))
                }
            )
            .navigationBarHidden(true)

        case .sendMoneyProcessing(let receipt):
            TransferProcessingFactory.make(
                receipt: receipt,
                onCompleted: {
                    replaceCurrentRoute(with: .sendMoneySuccess(receipt))
                }
            )
            .navigationBarHidden(true)

        case .sendMoneySuccess(let receipt):
            TransferSuccessFactory.make(
                model: receipt,
                onBack: { popRoute() },
                onDone: {
                    path.removeAll()
                },
                onNewTransfer: {
                    path.removeAll()
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
                coreService: coreService,
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
        guard !path.isEmpty else {
            path = [route]
            return
        }

        var updatedPath = path
        updatedPath.removeLast()
        updatedPath.append(route)
        path = updatedPath
    }
}
