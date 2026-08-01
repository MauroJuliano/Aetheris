import Core
import PaymentsInterface
import SwiftUI

@MainActor
public final class PaymentsFactory: PaymentsFactoryInterface {
    private let coreService: any HasCoreService
    private let profileStore = ProfileStore()

    public init(coreService: any HasCoreService) {
        self.coreService = coreService
    }
    
    public func make(entryPoint: PaymentsEntryPoint,
                     onFinished: @escaping () -> Void) -> AnyView {
        
        AnyView(PaymentsFlowCoordinator(entryPoint: entryPoint,
                                        coreService: coreService,
                                        profileStore: profileStore,
                                        onFinished: {
            onFinished()
        }))
    }
}
