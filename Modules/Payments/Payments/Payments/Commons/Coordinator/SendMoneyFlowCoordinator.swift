import Core
import UIKit
import SwiftUI

private enum SendMoneyFlowRoute: Hashable {
    case beneficiaryList
    case pin(TransferReceiptModel)
    case processing(TransferReceiptModel)
    case success(TransferReceiptModel)
}

struct SendMoneyFlowCoordinator: View {
    let coreService: any HasCoreService
    @Binding var selectedBeneficiary: Beneficiary
    let onBackAction: () -> Void

    @State private var path: [SendMoneyFlowRoute] = []

    var body: some View {
        NavigationStack(path: $path) {
            SendMoneyFactory.make(
                coreService: coreService,
                selectedBeneficiary: $selectedBeneficiary,
                onBackAction: onBackAction,
                onChangeBeneficiary: {
                    path.append(.beneficiaryList)
                },
                onContinue: { receipt in
                    path.append(.pin(receipt))
                }
            )
            .navigationDestination(for: SendMoneyFlowRoute.self) { route in
                switch route {
                case .beneficiaryList:
                    BeneficiaryListFactory.make(
                        coreService: coreService,
                        onSelect: { beneficiary in
                            RecentRecipientsStore.shared.record(beneficiary)
                            selectedBeneficiary = beneficiary
                            popRoute()
                        },
                        onBack: { popRoute() }
                    )
                    .navigationBarHidden(true)

                case .pin(let receipt):
                    TransferPinFactory.make(
                        receipt: receipt,
                        onBack: { popRoute() },
                        onValidPin: {
                            path.append(.processing(receipt))
                        }
                    )
                    .navigationBarHidden(true)

                case .processing(let receipt):
                    TransferProcessingFactory.make(
                        receipt: receipt,
                        onCompleted: {
                            replaceCurrentRoute(with: .success(receipt))
                        }
                    )
                    .navigationBarHidden(true)

                case .success(let receipt):
                    TransferSuccessFactory.make(
                        model: receipt,
                        onBack: { popRoute() },
                        onDone: {
                            path.removeAll()
                            onBackAction()
                        },
                        onNewTransfer: {
                            path.removeAll()
                        },
                        onCopyReference: { reference in
                            UIPasteboard.general.string = reference
                        }
                    )
                    .navigationBarHidden(true)
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }

    private func popRoute() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    private func replaceCurrentRoute(with route: SendMoneyFlowRoute) {
        if !path.isEmpty {
            path.removeLast()
        }
        path.append(route)
    }
}
