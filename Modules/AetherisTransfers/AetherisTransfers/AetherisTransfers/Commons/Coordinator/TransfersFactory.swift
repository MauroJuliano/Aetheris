import AetherisAuthenticationInterface
import Core
import AetherisTransfersInterface
import Foundation
import SwiftUI
import UIKit

public enum TransfersFactory {
    @MainActor
    public static func make(
        coreService: any HasCoreService,
        identityValidation: any IdentityValidating,
        selectedBeneficiary: Binding<Beneficiary?>,
        onFinished: @escaping () -> Void
    ) -> AnyView {
        AnyView(SendMoneyFlowCoordinator(
            coreService: coreService,
            identityValidation: identityValidation,
            selectedBeneficiary: selectedBeneficiary,
            onBackAction: onFinished
        ))
    }

    @MainActor
    public static func makeEmbedded(
        coreService: any HasCoreService,
        identityValidation: any IdentityValidating,
        selectedBeneficiary: Binding<Beneficiary?>,
        path: Binding<NavigationPath>,
        onFinished: @escaping () -> Void
    ) -> AnyView {
        AnyView(SendMoneyFactory.make(
            coreService: coreService,
            selectedBeneficiary: selectedBeneficiary,
            onBackAction: onFinished,
            onChangeBeneficiary: {
                path.wrappedValue.append(SendMoneyFlowRoute.beneficiaryList(.transferSelection))
            },
            onContinue: { draft in
                path.wrappedValue.append(SendMoneyFlowRoute.pin(draft))
            }
        ))
    }

    @MainActor
    public static func makeNavigationHost(
        content: AnyView,
        coreService: any HasCoreService,
        identityValidation: any IdentityValidating,
        selectedBeneficiary: Binding<Beneficiary?>,
        path: Binding<NavigationPath>,
        onFinished: @escaping () -> Void
    ) -> AnyView {
        AnyView(
            content.navigationDestination(for: SendMoneyFlowRoute.self) { route in
                embeddedDestination(
                    for: route,
                    coreService: coreService,
                    identityValidation: identityValidation,
                    selectedBeneficiary: selectedBeneficiary,
                    path: path,
                    onFinished: onFinished
                )
            }
        )
    }

    @MainActor
    public static func makeBeneficiaryList(
        coreService: any HasCoreService,
        onSelect: @escaping (Beneficiary) -> Void,
        onBack: @escaping () -> Void
    ) -> AnyView {
        AnyView(BeneficiaryListFactory.make(coreService: coreService, onSelect: onSelect, onBack: onBack))
    }

    @MainActor
    public static func makeBeneficiarySearch(
        coreService: any HasCoreService,
        onSelect: @escaping (Beneficiary) -> Void,
        onBack: @escaping () -> Void
    ) -> AnyView {
        AnyView(BeneficiaryAddFactory.make(coreService: coreService, onBack: onBack, onComplete: onSelect))
    }

    @MainActor
    public static func makeRequestMoney(
        coreService: any HasCoreService,
        onBack: @escaping () -> Void,
        onFinished: @escaping () -> Void
    ) -> AnyView {
        AnyView(
            RequestMoneyFactory.make(
                coreService: coreService,
                onBackAction: onBack,
                onSuccess: { _ in
                    onFinished()
                }
            )
        )
    }

    @MainActor
    public static func makeRequestMoneyWithContactPicker(
        coreService: any HasCoreService,
        path: Binding<NavigationPath>,
        onBack: @escaping () -> Void,
        onFinished: @escaping () -> Void
    ) -> AnyView {
        AnyView(
            RequestMoneyFactory.make(
                coreService: coreService,
                onBackAction: onBack,
                onContactSearchTap: {
                    path.wrappedValue.append(SendMoneyFlowRoute.beneficiaryList(.detailsNavigation))
                },
                onSuccess: { _ in
                    onFinished()
                }
            )
        )
    }

    @MainActor
    public static func makeBeneficiaryDetails(
        coreService: any HasCoreService,
        beneficiaryId: UUID,
        path: Binding<NavigationPath>,
        onBack: @escaping () -> Void,
        onTransferTap: @escaping (Beneficiary) -> Void,
        onBeneficiaryRemoved: @escaping () -> Void
    ) -> AnyView {
        AnyView(
            BeneficiaryDetailsFactory.make(
                coreService: coreService,
                beneficiaryId: beneficiaryId,
                onBackAction: onBack,
                onTransferTap: onTransferTap,
                onRequestMoneyTap: { contact in
                    path.wrappedValue.append(SendMoneyFlowRoute.requestMoney(contact))
                },
                onBeneficiaryRemoved: onBeneficiaryRemoved
            )
        )
    }

    @MainActor
    @ViewBuilder
    private static func embeddedDestination(
        for route: SendMoneyFlowRoute,
        coreService: any HasCoreService,
        identityValidation: any IdentityValidating,
        selectedBeneficiary: Binding<Beneficiary?>,
        path: Binding<NavigationPath>,
        onFinished: @escaping () -> Void
    ) -> some View {
        switch route {
        case .beneficiaryList(let context):
            BeneficiaryListFactory.make(
                coreService: coreService,
                onSelect: { beneficiary in
                    switch context {
                    case .transferSelection:
                        selectedBeneficiary.wrappedValue = beneficiary
                        pop(path)

                    case .detailsNavigation:
                        path.wrappedValue.append(SendMoneyFlowRoute.beneficiaryDetails(beneficiary.id))
                    }
                },
                onBack: { pop(path) }
            )
            .navigationBarHidden(true)

        case .beneficiaryDetails(let beneficiaryId):
            BeneficiaryDetailsFactory.make(
                coreService: coreService,
                beneficiaryId: beneficiaryId,
                onBackAction: { pop(path) },
                onTransferTap: { beneficiary in
                    selectedBeneficiary.wrappedValue = beneficiary
                    returnToSendMoney(path)
                },
                onRequestMoneyTap: { contact in
                    path.wrappedValue.append(SendMoneyFlowRoute.requestMoney(contact))
                },
                onBeneficiaryRemoved: {
                    returnToSendMoney(path)
                }
            )
            .navigationBarHidden(true)

        case .requestMoney(let contact):
            RequestMoneyFactory.make(
                coreService: coreService,
                initialContact: contact,
                onBackAction: { pop(path) },
                onSuccess: { _ in
                    returnToSendMoney(path)
                }
            )
            .navigationBarHidden(true)

        case .pin(let draft):
            identityValidation.authenticate(
                content: identityContent(for: draft),
                onCancel: { pop(path) },
                onResult: { result in
                    switch result {
                    case let .authorized(authorization):
                        path.wrappedValue.append(SendMoneyFlowRoute.processing(.init(
                            draft: draft,
                            authorization: authorization,
                            idempotencyKey: UUID().uuidString
                        )))
                    case .failed:
                        returnToSendMoney(path)
                    @unknown default:
                        returnToSendMoney(path)
                    }
                }
            )
            .navigationBarHidden(true)

        case .processing(let submission):
            TransferProcessingFactory.make(
                coreService: coreService,
                submission: submission,
                onCompleted: { receipt in
                    replaceCurrent(with: .success(receipt), in: path)
                },
                onTryLater: { returnToSendMoney(path) }
            )
            .navigationBarHidden(true)

        case .success(let receipt):
            TransferSuccessFactory.make(
                model: receipt,
                onBack: onFinished,
                onDone: onFinished,
                onNewTransfer: { returnToSendMoney(path) },
                onCopyReference: { reference in
                    UIPasteboard.general.string = reference
                }
            )
            .navigationBarHidden(true)
        }
    }

    private static func pop(_ path: Binding<NavigationPath>) {
        guard !path.wrappedValue.isEmpty else { return }
        path.wrappedValue.removeLast()
    }

    private static func replaceCurrent(
        with route: SendMoneyFlowRoute,
        in path: Binding<NavigationPath>
    ) {
        pop(path)
        path.wrappedValue.append(route)
    }

    private static func returnToSendMoney(_ path: Binding<NavigationPath>) {
        guard path.wrappedValue.count > 1 else { return }
        path.wrappedValue.removeLast(path.wrappedValue.count - 1)
    }

    private static func identityContent(for draft: TransferDraft) -> IdentityValidationContent {
        IdentityValidationContent(
            navigationTitle: Strings.TransferPin.confirmTransfer,
            title: Strings.TransferPin.title,
            description: Strings.TransferPin.subtitle(draft.formattedAmount, draft.beneficiaryName)
        )
    }
}
