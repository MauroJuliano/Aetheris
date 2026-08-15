import Core
import SwiftUI

@MainActor
public protocol HasRegistration {
    var registrationFactory: RegistrationFactoryInterface { get }
}

@MainActor
public protocol RegistrationFactoryInterface {
    init(coreService: any HasCoreService)
    func make(
        onFinished: @escaping () -> Void,
        onBackToLogin: @escaping () -> Void
    ) -> AnyView
}
