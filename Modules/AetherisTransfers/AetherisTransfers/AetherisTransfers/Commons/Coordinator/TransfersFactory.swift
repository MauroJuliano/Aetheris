import Core
import AetherisTransfersInterface
import Foundation
import SwiftUI
import UIKit

public enum TransfersFactory {
    @MainActor
    public static func make(
        coreService: any HasCoreService,
        selectedBeneficiary: Binding<Beneficiary>,
        onFinished: @escaping () -> Void
    ) -> AnyView {
        AnyView(SendMoneyFlowCoordinator(
            coreService: coreService,
            selectedBeneficiary: selectedBeneficiary,
            onBackAction: onFinished
        ))
    }

    @MainActor
    public static func makeEmbedded(
        coreService: any HasCoreService,
        selectedBeneficiary: Binding<Beneficiary>,
        path: Binding<NavigationPath>,
        onFinished: @escaping () -> Void
    ) -> AnyView {
        AnyView(SendMoneyFactory.make(
            coreService: coreService,
            selectedBeneficiary: selectedBeneficiary,
            onBackAction: onFinished,
            onChangeBeneficiary: {
                path.wrappedValue.append(SendMoneyFlowRoute.beneficiaryList)
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
        selectedBeneficiary: Binding<Beneficiary>,
        path: Binding<NavigationPath>,
        onFinished: @escaping () -> Void
    ) -> AnyView {
        AnyView(
            content.navigationDestination(for: SendMoneyFlowRoute.self) { route in
                embeddedDestination(
                    for: route,
                    coreService: coreService,
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
    @ViewBuilder
    private static func embeddedDestination(
        for route: SendMoneyFlowRoute,
        coreService: any HasCoreService,
        selectedBeneficiary: Binding<Beneficiary>,
        path: Binding<NavigationPath>,
        onFinished: @escaping () -> Void
    ) -> some View {
        switch route {
        case .beneficiaryList:
            BeneficiaryListFactory.make(
                coreService: coreService,
                onSelect: { beneficiary in
                    selectedBeneficiary.wrappedValue = beneficiary
                    pop(path)
                },
                onBack: { pop(path) }
            )
            .navigationBarHidden(true)

        case .pin(let draft):
            TransferPinFactory.make(
                coreService: coreService,
                draft: draft,
                onBack: { pop(path) },
                onAuthorized: { authorization in
                    path.wrappedValue.append(SendMoneyFlowRoute.processing(.init(
                        draft: draft,
                        authorization: authorization,
                        idempotencyKey: UUID().uuidString
                    )))
                },
                onValidationFailed: { pop(path) }
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
}
