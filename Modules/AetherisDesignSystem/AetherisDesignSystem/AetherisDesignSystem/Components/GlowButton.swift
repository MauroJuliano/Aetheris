import SwiftUI

public struct GlowButton: View {
    private var title: String = Strings.GlowButton.continueTitle
    private var action: () -> Void = {}
    private var isLoading = false
    
    @State private var isAnimating = false
    
    public init(
        title: String,
        action: @escaping () -> Void = {},
        isLoading: Bool = false
    ) {
        self.title = title
        self.action = action
        self.isLoading = isLoading
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
                ZStack {
                    Text(title)
                        .font(AppTypography.button)
                        .foregroundStyle(Color.brandPrimaryColor)
                        .opacity(isLoading ? 0 : 1)

                    if isLoading {
                        ProgressView()
                            .tint(Color.brandPrimaryColor)
                    }
                }
                .frame(width: AppComponentMetrics.glowButtonWidth, height: AppComponentMetrics.glowButtonHeight)
                .appShadow(AppShadow.control)
                .background(Color.backgroundColorA)
                .clipShape(RoundedRectangle(cornerRadius: AppRadius.pill))
            }
            .disabled(isLoading)
        }
    }

    @ViewBuilder
    public func toSkeleton(enable: Bool) -> some View {
        if enable {
            GlowButtonSkeleton()
        } else {
            self
        }
    }
}

#Preview {
    GlowButton(title: "Continue")
        .padding()
        .appScreenBackground()
}
