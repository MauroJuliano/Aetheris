import SwiftUI

public protocol HasRegistration {
    var registrationFactory: RegistrationFactoryInterface { get }
}

public protocol RegistrationFactoryInterface {
    func make(onFinished: @escaping () -> Void) -> AnyView
}
