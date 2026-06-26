import SwiftUI

public struct AvatarModel {
    let image: String
    
    public init(image: String) {
        self.image = image
    }
}

public struct AvatarTemplate: View {
    private var model: AvatarModel
    @State private var rotateGradient: Bool
    
    public init(model: AvatarModel,
                rotateGradient: Bool = false) {
        self.model = model
        self.rotateGradient = rotateGradient
    }
    
    public var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.blue.opacity(0.4), Color.purple.opacity(0.4)],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(width: 120, height: 120)
            .clipShape(Circle())
            .blur(radius: 20)
            .rotationEffect(.degrees(rotateGradient ? 360 : 0))
            .animation(.linear(duration: 6).repeatForever(autoreverses: false), value: rotateGradient)
            .offset(y: 5)
            
            Image(model.image)
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .clipped()
                .shadow(radius: 10)
                .overlay(
                    Circle()
                        .stroke(.gray.opacity(0.25), style: .init(lineWidth: 1))
                )
            .frame(width: 150, height: 150)
        }
        .onAppear {
            rotateGradient = true
        }
    }
}

#Preview {
    AvatarTemplate(model: .init(image: "melissa"))
}
