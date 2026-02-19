import SwiftUI

struct GlowButton: View {
    var title: String = "Continue"
    var action: () -> Void = {}

    @State private var isAnimating = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(AngularGradient(colors: [Color.accentColorBrown, .white, Color.accentColorBrown], center: .center, angle: .degrees(isAnimating ? 360 : 0)))
                .frame(width: 250, height: 50)
                .blur(radius: 10)
                .onAppear {
                    withAnimation(Animation.linear(duration: 7).repeatForever(autoreverses: false)) {
                        isAnimating = true
                    }
                }
            
            Button(action: action) {
                Text(title)
                    .foregroundStyle(Color.accentColorBrown)
                    .frame(width: 250, height: 50)
                    .shadow(color: .black.opacity(0.2), radius: 10, y: 5)
                    .background(Color.backgroundColorA)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
            }
        }
    }
}


#Preview {
    GlowButton()
}
