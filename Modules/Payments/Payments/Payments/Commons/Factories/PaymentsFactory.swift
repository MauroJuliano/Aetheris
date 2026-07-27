import Core
import PaymentsInterface
import SwiftUI

public final class PaymentsFactory: PaymentsFactoryInterface {
    private let coreService: any HasCoreService

    public init(coreService: any HasCoreService) {
        self.coreService = coreService
    }
    
    public func make(entryPoint: PaymentsEntryPoint,
                     onFinished: @escaping () -> Void) -> AnyView {
        
        AnyView(PaymentsFlowCoordinator(entryPoint: entryPoint,
                                        coreService: coreService,
                                        onFinished: {
            onFinished()
        }))
    }
}
