import SwiftUI
import AetherisAuthentication
import AetherisAuthenticationInterface
import AERegistration
import Core

@main
struct AetherisApp: App {
    private let dependencies = DependencyContainer()
    @StateObject private var sessionStore: AppSessionStore
    @State private var languageRevision = UUID()

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
            .id(languageRevision)
            .environment(
                \.locale,
                Locale(identifier: dependencies.languageManager.effectiveLanguage.languageCode ?? Locale.current.identifier)
            )
            .onReceive(NotificationCenter.default.publisher(for: .aetherisLanguageDidChange)) { _ in
                languageRevision = UUID()
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
