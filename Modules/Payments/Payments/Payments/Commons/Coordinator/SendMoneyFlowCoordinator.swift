import AetherisAuthenticationInterface
import Core
import UIKit
import SwiftUI

enum SendMoneyFlowRoute: Hashable {
    case beneficiaryList
    case pin(TransferDraft)
    case processing(TransferSubmission)
    case success(TransferReceiptModel)
}

struct SendMoneyNavigationState {
    var path: [SendMoneyFlowRoute] = []
    var isAtRoot: Bool { path.isEmpty }

    mutating func push(_ route: SendMoneyFlowRoute) {
        path.append(route)
    }

    mutating func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    mutating func replaceCurrent(with route: SendMoneyFlowRoute) {
        if !path.isEmpty {
            path.removeLast()
        }
        path.append(route)
    }

    mutating func reset() {
        path.removeAll()
    }
}

struct SendMoneyFlowCoordinator: View {
    let coreService: any HasCoreService
    let identityValidation: any IdentityValidating
    @Binding var selectedBeneficiary: Beneficiary
    let onBackAction: () -> Void

    @State private var navigation = SendMoneyNavigationState()

    var body: some View {
        NavigationStack(path: $navigation.path) {
            SendMoneyFactory.make(
                coreService: coreService,
                selectedBeneficiary: $selectedBeneficiary,
                onBackAction: onBackAction,
                onChangeBeneficiary: {
                    navigation.push(.beneficiaryList)
                },
                onContinue: { receipt in
                    navigation.push(.pin(receipt))
                }
            )
            .navigationDestination(for: SendMoneyFlowRoute.self) { route in
                switch route {
                case .beneficiaryList:
                    BeneficiaryListFactory.make(
                        coreService: coreService,
                        onSelect: { beneficiary in
                            selectedBeneficiary = beneficiary
                            popRoute()
                        },
                        onBack: { popRoute() }
                    )
                    .navigationBarHidden(true)

                case .pin(let draft):
                    identityValidation.authenticate(
                        content: identityContent(for: draft),
                        onCancel: { popRoute() },
                        onResult: { result in
                            switch result {
                            case let .authorized(authorization):
                                navigation.push(.processing(.init(
                                    draft: draft,
                                    authorization: authorization,
                                    idempotencyKey: UUID().uuidString
                                )))
                            case .failed:
                                navigation.reset()
                            }
                        }
                    )
                    .navigationBarHidden(true)

                case .processing(let submission):
                    TransferProcessingFactory.make(
                        coreService: coreService,
                        submission: submission,
                        onCompleted: { receipt in
                            replaceCurrentRoute(with: .success(receipt))
                        },
                        onTryLater: {
                            navigation.reset()
                        }
                    )
                    .navigationBarHidden(true)

                case .success(let receipt):
                    TransferSuccessFactory.make(
                        model: receipt,
                        onBack: {
                            navigation.reset()
                            onBackAction()
                        },
                        onDone: {
                            navigation.reset()
                            onBackAction()
                        },
                        onNewTransfer: {
                            navigation.reset()
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
        navigation.pop()
    }

    private func replaceCurrentRoute(with route: SendMoneyFlowRoute) {
        navigation.replaceCurrent(with: route)
    }

    private func identityContent(for draft: TransferDraft) -> IdentityValidationContent {
        IdentityValidationContent(
            navigationTitle: Strings.TransferPin.confirmTransfer,
            title: Strings.TransferPin.title,
            description: Strings.TransferPin.subtitle(draft.formattedAmount, draft.beneficiaryName)
        )
    }
}
