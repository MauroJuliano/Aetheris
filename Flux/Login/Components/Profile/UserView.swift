import SwiftUI

struct UserView: View {
    @State private var rotateGradient = false
    
    var body: some View {
        VStack {
            ZStack {
                LinearGradient(
                    colors: [Color.blue.opacity(0.4), Color.purple.opacity(0.4)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(width: 160, height: 160) // slightly bigger than card
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
                .frame(width: 200, height: 200)
            }
            .onAppear {
                rotateGradient = true
            }
            
            Text("Melissa Mccarthy")
                .foregroundStyle(.black)
                .font(AppFont.roboto(.semibold, size: 28))
            
            Text("Joined August 17, 2025")
                .foregroundStyle(.gray)
                .font(AppFont.roboto(.semibold, size: 18))
        }
        .frame(width: 300, height: 300)
    }
}

#Preview {
    UserView()
}
