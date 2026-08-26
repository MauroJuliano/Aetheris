import SwiftUI

public struct AvatarTemplate: View {
    private var model: AvatarModel
    @State private var rotateGradient: Bool
    
    public init(model: AvatarModel,
                rotateGradient: Bool = false) {
        self.model = model
        self._rotateGradient = State(initialValue: rotateGradient)
    }
    
    public var body: some View {
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
            
            Image(model.image)
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
    }

    @ViewBuilder
    public func toSkeleton(enable: Bool) -> some View {
        if enable {
            AvatarTemplateSkeleton()
        } else {
            self
        }
    }
}

#Preview {
    AvatarTemplate(model: .init(image: "blake"))
        .padding()
        .appScreenBackground()
}
