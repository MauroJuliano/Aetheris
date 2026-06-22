import SwiftUI
import AetherisAuthentication
import AERegistration
import Payments

@main
struct AetherisApp: App {
    private let dependencies = DependencyContainer()
    
    var body: some Scene {
        WindowGroup {
            dependencies.authenticationFactory.make()
        }
    }
}
