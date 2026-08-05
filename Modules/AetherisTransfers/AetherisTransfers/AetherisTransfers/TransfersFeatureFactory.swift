import AetherisTransfersInterface
import Core
import SwiftUI

public final class TransfersFeatureFactory: TransfersFactoryInterface {
    private let coreService: any HasCoreService
    private var beneficiary = BeneficiaryFixtures.defaultSelection
    public init(coreService: any HasCoreService) { self.coreService = coreService }

    @MainActor public func make(onFinished: @escaping () -> Void) -> AnyView {
        TransfersFactory.make(
            coreService: coreService,
            selectedBeneficiary: Binding(get: { self.beneficiary }, set: { self.beneficiary = $0 }),
            onFinished: onFinished
        )
    }
}
