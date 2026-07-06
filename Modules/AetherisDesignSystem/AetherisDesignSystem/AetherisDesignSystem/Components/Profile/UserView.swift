import SwiftUI

public struct UserView: View {
    @State private var rotateGradient: Bool
    
    public init(rotateGradient: Bool = false) {
        self.rotateGradient = rotateGradient
    }
    
    public var body: some View {
        HStack {
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
                
                Image("melissa")
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
