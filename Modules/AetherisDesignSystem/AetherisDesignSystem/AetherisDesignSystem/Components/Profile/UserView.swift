import SwiftUI

public struct UserView: View {
    @State private var rotateGradient: Bool
    
    public init(rotateGradient: Bool = false) {
        self._rotateGradient = State(initialValue: rotateGradient)
    }
    
    public var body: some View {
        HStack {
            ZStack {
                LinearGradient(
                    colors: [Color.blue.opacity(0.4), Color.purple.opacity(0.4)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(width: AppAvatarMetrics.glowSize, height: AppAvatarMetrics.glowSize)
                .clipShape(Circle())
                .blur(radius: AppAvatarMetrics.glowBlurRadius)
                .rotationEffect(.degrees(rotateGradient ? 360 : 0))
                .animation(.linear(duration: 6).repeatForever(autoreverses: false), value: rotateGradient)
                .offset(y: AppAvatarMetrics.glowOffsetY)
                
                Image("melissa")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .clipped()
                    .shadow(radius: AppAvatarMetrics.glowBlurRadius / 2)
                    .overlay(
                        Circle()
                            .stroke(.gray.opacity(0.25), style: .init(lineWidth: 1))
                    )
                .frame(width: AppAvatarMetrics.imageSize, height: AppAvatarMetrics.imageSize)
            }
            .onAppear {
                rotateGradient = true
            }
            
            VStack(alignment: .leading) {
                Text("Melissa Mccarthy")
                    .foregroundStyle(Color.textPrimary)
                    .font(AppTypography.onboardingBody)
                
                Text("Joined August 17, 2025")
                    .foregroundStyle(Color.brandPrimaryColor)
                    .font(AppTypography.caption)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    UserView()
}
