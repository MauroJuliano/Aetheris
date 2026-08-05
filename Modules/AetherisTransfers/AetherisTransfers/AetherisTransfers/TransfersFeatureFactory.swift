import AetherisAuthenticationInterface
import AetherisTransfersInterface
import Core
import SwiftUI

public final class TransfersFeatureFactory: TransfersFactoryInterface {
    private let coreService: any HasCoreService
    private let identityValidation: any IdentityValidating
    private var beneficiary = BeneficiaryFixtures.defaultSelection

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
}
