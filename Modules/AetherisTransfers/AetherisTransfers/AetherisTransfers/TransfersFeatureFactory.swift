import AetherisAuthenticationInterface
import AetherisTransfersInterface
import Core
import SwiftUI

public final class TransfersFeatureFactory: TransfersFactoryInterface {
    private let coreService: any HasCoreService
    private let identityValidation: any IdentityValidating
    private var beneficiary: Beneficiary?

    public init(
        coreService: any HasCoreService,
        identityValidation: any IdentityValidating
    ) {
        self.coreService = coreService
        self.identityValidation = identityValidation
    }

    @MainActor public func make(onFinished: @escaping () -> Void) -> AnyView {
        TransfersFactory.make(
            coreService: coreService,
            identityValidation: identityValidation,
            selectedBeneficiary: Binding(get: { self.beneficiary }, set: { self.beneficiary = $0 }),
            onFinished: onFinished
        )
    }

    @MainActor public func makeRequestMoney(
        onFinished: @escaping () -> Void
    ) -> AnyView {
        TransfersFactory.makeRequestMoney(
            coreService: coreService,
            onBack: onFinished,
            onFinished: onFinished
        )
    }

    @MainActor public func makeEmbedded(
        path: Binding<NavigationPath>,
        onFinished: @escaping () -> Void
    ) -> AnyView {
        TransfersFactory.makeEmbedded(
            coreService: coreService,
            identityValidation: identityValidation,
            selectedBeneficiary: beneficiaryBinding,
            path: path,
            onFinished: onFinished
        )
    }

    @MainActor public func makeRequestMoneyEmbedded(
        path: Binding<NavigationPath>,
        onFinished: @escaping () -> Void
    ) -> AnyView {
        TransfersFactory.makeRequestMoneyWithContactPicker(
            coreService: coreService,
            path: path,
            onBack: onFinished,
            onFinished: onFinished
        )
    }

    @MainActor public func makeNavigationHost(
        content: AnyView,
        path: Binding<NavigationPath>,
        onFinished: @escaping () -> Void,
        onTransactionTap: @escaping (UUID) -> Void
    ) -> AnyView {
        TransfersFactory.makeNavigationHost(
            content: content,
            coreService: coreService,
            identityValidation: identityValidation,
            selectedBeneficiary: beneficiaryBinding,
            path: path,
            onFinished: onFinished,
            onTransactionTap: onTransactionTap
        )
    }

    private var beneficiaryBinding: Binding<Beneficiary?> {
        Binding(get: { self.beneficiary }, set: { self.beneficiary = $0 })
    }
}
