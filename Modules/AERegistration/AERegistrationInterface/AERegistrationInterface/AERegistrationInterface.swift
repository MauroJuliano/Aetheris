import Core
import SwiftUI

public protocol HasRegistration {
    var registrationFactory: RegistrationFactoryInterface { get }
}

public protocol RegistrationFactoryInterface {
    init(coreService: any HasCoreService)
    func make(onFinished: @escaping () -> Void) -> AnyView
}
