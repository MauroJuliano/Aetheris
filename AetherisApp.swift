import SwiftUI
import AetherisAuthentication
import AetherisAuthenticationInterface
import AERegistration
import Payments
import Core

@main
struct AetherisApp: App {
    private let dependencies = DependencyContainer()
    @StateObject private var sessionStore = AppSessionStore()
    
    var body: some Scene {
        WindowGroup {
            SplashRootView {
                dependencies.authenticationFactory.make()
                    .environmentObject(sessionStore)
            }
        }
    }
}

struct SplashRootView<Content: View>: View {
    @State private var isSplashVisible = true
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
            try? await Task.sleep(nanoseconds: 1_500_000_000)
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
