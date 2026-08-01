import SwiftUI
import AetherisAuthentication
import AetherisAuthenticationInterface
import AERegistration
import Payments
import Core

@main
struct AetherisApp: App {
    private let dependencies = DependencyContainer()
    @StateObject private var sessionStore: AppSessionStore

    init() {
        let session = AppSessionStore()
        session.isAuthenticated = UITestConfiguration.startsAuthenticated
        _sessionStore = StateObject(wrappedValue: session)
    }
    
    var body: some Scene {
        WindowGroup {
            SplashRootView(delay: UITestConfiguration.isEnabled ? 0 : 1.5) {
                dependencies.authenticationFactory.make()
                    .environmentObject(sessionStore)
            }
        }
    }
}

struct SplashRootView<Content: View>: View {
    @State private var isSplashVisible = true
    let delay: TimeInterval
    let content: () -> Content
    
    var body: some View {
        ZStack {
            if isSplashVisible {
                SplashView()
            } else {
                content()
            }
        }
        .task {
            try? await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
            withAnimation(.easeOut(duration: 0.25)) {
                isSplashVisible = false
            }
        }
    }
}

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.brandPrimaryColor
                .ignoresSafeArea()

            Image("launchScreen")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
    }
}
