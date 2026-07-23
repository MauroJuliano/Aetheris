import UIKit
import SwiftUI

private enum SendMoneyFlowRoute: Hashable {
    case beneficiaryList
    case pin
    case processing
    case success
}

struct SendMoneyFlowCoordinator: View {
    @Binding var selectedBeneficiary: Beneficiary
    let onBackAction: () -> Void

    @State private var path: [SendMoneyFlowRoute] = []
    @State private var transferReceipt: TransferReceiptModel?

    var body: some View {
        NavigationStack(path: $path) {
            SendMoneyFactory.make(
                selectedBeneficiary: $selectedBeneficiary,
                onBackAction: onBackAction,
                onChangeBeneficiary: {
                    path.append(.beneficiaryList)
                },
                onContinue: { receipt in
                    transferReceipt = receipt
                    path.append(.pin)
                }
            )
            .navigationDestination(for: SendMoneyFlowRoute.self) { route in
                switch route {
                case .beneficiaryList:
                    BeneficiaryListFactory.make(
                        onSelect: { beneficiary in
                            selectedBeneficiary = beneficiary
                            popRoute()
                        },
                        onBack: { popRoute() }
                    )
                    .navigationBarHidden(true)

                case .pin:
                    if let receipt = transferReceipt {
                        TransferPinFactory.make(
                            receipt: receipt,
                            onBack: { popRoute() },
                            onValidPin: {
                                path.append(.processing)
                            }
                        )
                        .navigationBarHidden(true)
                    } else {
                        EmptyView()
                    }

                case .processing:
                    if let receipt = transferReceipt {
                        TransferProcessingFactory.make(
                            receipt: receipt,
                            onCompleted: {
                                replaceCurrentRoute(with: .success)
                            }
                        )
                        .navigationBarHidden(true)
                    } else {
                        EmptyView()
                    }

                case .success:
                    if let receipt = transferReceipt {
                        TransferSuccessFactory.make(
                            model: receipt,
                            onBack: { popRoute() },
                            onDone: {
                                path.removeAll()
                                onBackAction()
                            },
                            onNewTransfer: {
                                transferReceipt = nil
                                path.removeAll()
                            },
                            onCopyReference: { reference in
                                UIPasteboard.general.string = reference
                            }
                        )
                        .navigationBarHidden(true)
                    } else {
                        EmptyView()
                    }
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
