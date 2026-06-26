import SwiftUI
import AetherisAuthentication
import AERegistration
import Payments

@main
struct AetherisApp: App {
    private let dependencies = DependencyContainer()
    
    var body: some Scene {
        WindowGroup {
            SplashRootView {
                dependencies.authenticationFactory.make()
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
            
            Text("Aetheris")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)
        }
    }
}
