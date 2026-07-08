import SwiftUI

public struct GlowButton: View {
    private var title: String = "Continue"
    private var action: () -> Void = {}
    
    @State private var isAnimating = false
    
    public init(
        title: String,
        action: @escaping () -> Void = {}
    ) {
        self.title = title
        self.action = action
    }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: AppRadius.pill, style: .continuous)
                .fill(AngularGradient(colors: [Color.brandPrimaryColor, .white, Color.brandPrimaryColor], center: .center, angle: .degrees(isAnimating ? 360 : 0)))
                .frame(width: AppComponentMetrics.glowButtonWidth, height: AppComponentMetrics.glowButtonHeight)
                .blur(radius: 10)
                .onAppear {
                    withAnimation(Animation.linear(duration: 7).repeatForever(autoreverses: false)) {
                        isAnimating = true
                    }
                }
            
            Button(action: action) {
                Text(title)
                    .font(AppTypography.button)
                    .foregroundStyle(Color.brandPrimaryColor)
                    .frame(width: AppComponentMetrics.glowButtonWidth, height: AppComponentMetrics.glowButtonHeight)
                    .appShadow(AppShadow.control)
                    .background(Color.backgroundColorA)
                    .clipShape(RoundedRectangle(cornerRadius: AppRadius.pill))
            }
        }
    }
}


#Preview {
    GlowButton(title: "Continue")
}
