import PaymentsInterface
import SwiftUI

public final class PaymentsFactory: PaymentsFactoryInterface {
    public init() {}
    
    public func make(entryPoint: PaymentsEntryPoint,
                     onFinished: @escaping () -> Void) -> AnyView {
        
        AnyView(PaymentsFlowCoordinator(entryPoint: entryPoint,
                                        onFinished: {
            onFinished()
        }))
    }
}
