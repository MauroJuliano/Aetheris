import SwiftUI

struct BottomOverlayView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            // Background image
            Image("melissa")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            // Bottom panel
            VStack(spacing: 16) {
                Text("Here is some info")
                    .font(.title)
                    .fontWeight(.bold)
                
                Button(action: {
                    print("Button tapped")
                }) {
                    Text("Continue")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(12)
                }
            }
            .padding()
            .background(
                RoundedCorner(radius: 30, corners: [.topLeft, .topRight])
                    .fill(Color.white)
                    .shadow(radius: 5)
            )
        }
    }
}


struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct BottomOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        BottomOverlayView()
    }
}
