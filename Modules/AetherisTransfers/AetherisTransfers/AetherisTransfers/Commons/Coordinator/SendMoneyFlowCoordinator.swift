import AetherisDesignSystem
import AetherisAuthenticationInterface
import Core
import UIKit
import SwiftUI

enum SendMoneyFlowRoute: Hashable {
    case beneficiaryList(BeneficiaryListSelectionContext)
    case beneficiaryDetails(UUID)
    case requestMoney(RequestContactModel)
    case pin(TransferDraft)
    case processing(TransferSubmission)
    case success(TransferReceiptModel)
}

enum BeneficiaryListSelectionContext: Hashable {
    case transferSelection
    case detailsNavigation
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
    @Binding var selectedBeneficiary: Beneficiary?
    let onBackAction: () -> Void

    @State private var navigation = SendMoneyNavigationState()

    var body: some View {
        NavigationStack(path: $navigation.path) {
            SendMoneyFactory.make(
                coreService: coreService,
                selectedBeneficiary: $selectedBeneficiary,
                onBackAction: onBackAction,
                onChangeBeneficiary: {
                    navigation.push(.beneficiaryList(.transferSelection))
                },
                onContinue: { receipt in
                    navigation.push(.pin(receipt))
                }
            )
            .navigationDestination(for: SendMoneyFlowRoute.self) { route in
                switch route {
                case .beneficiaryList(let context):
                    BeneficiaryListFactory.make(
                        coreService: coreService,
                        onSelect: { beneficiary in
                            switch context {
                            case .transferSelection:
                                selectedBeneficiary = beneficiary
                                navigation.reset()

                            case .detailsNavigation:
                                navigation.push(.beneficiaryDetails(beneficiary.id))
                            }
                        },
                        onBack: { popRoute() }
                    )
                    .navigationBarHidden(true)

                case .beneficiaryDetails(let beneficiaryId):
                    BeneficiaryDetailsFactory.make(
                        coreService: coreService,
                        beneficiaryId: beneficiaryId,
                        onBackAction: { popRoute() },
                        onTransferTap: { beneficiary in
                            selectedBeneficiary = beneficiary
                            navigation.reset()
                        },
                        onRequestMoneyTap: { contact in
                            navigation.push(.requestMoney(contact))
                        },
                        onBeneficiaryRemoved: {
                            navigation.reset()
                        }
                    )
                    .navigationBarHidden(true)

                case .requestMoney(let contact):
                    RequestMoneyFactory.make(
                        coreService: coreService,
                        initialContact: contact,
                        onBackAction: { popRoute() },
                        onSuccess: { _ in
                            navigation.reset()
                        }
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
                            @unknown default:
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

#Preview {
    @Previewable @State var beneficiary: Beneficiary? = BeneficiaryFixtures.defaultSelection

    SendMoneyFlowCoordinator(
        coreService: DemoCoreService(delay: 0),
        identityValidation: PreviewIdentityValidator(),
        selectedBeneficiary: $beneficiary,
        onBackAction: {}
    )
}

private struct PreviewIdentityValidator: IdentityValidating {
    @MainActor
    func authenticate(
        content: IdentityValidationContent,
        onCancel: @escaping () -> Void,
        onResult: @escaping (IdentityValidationResult) -> Void
    ) -> AnyView {
        AnyView(
            VStack(spacing: AppSpacing.medium) {
                Text(content.title)
                    .font(AppTypography.sectionTitle)
                    .foregroundStyle(Color.textPrimary)

                Text(content.description)
                    .font(AppTypography.body)
                    .foregroundStyle(Color.textSecondaryColor)
                    .multilineTextAlignment(.center)

                PrimaryButton(title: Strings.Common.continueButton) {
                    onResult(
                        .authorized(
                            IdentityAuthorization(
                                token: "preview-token",
                                expiresAt: "2026-08-07T23:59:59Z"
                            )
                        )
                    )
                }
            }
            .padding()
            .appScreenBackground()
        )
    }
}
