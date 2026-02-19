import SwiftUI

struct BulletPoint: View {
    let text: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Image(systemName: "circle.fill")
                    .font(.system(size: 6))
                    .padding(.top, 4)
            Text(text)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}


struct CardInsurance: View {
    var body: some View {
        // ScrollView {
        VStack {
            Image("melissa")
                .resizable()
                .frame(height: 500)
                .scaledToFit()
                .shadow(color: .gray.opacity(0.2), radius: 16, y: 5)
                .overlay {
                    VStack {
                        VStack(alignment: .leading, spacing: 12) {
                            BulletPoint(text: "Covers unauthorized transactions made after card theft or cloning.")
                            BulletPoint(text: "Quick replacement of lost or stolen cards.")
                            BulletPoint(text: "Insures eligible purchases against damage or theft for a limited period")
                            BulletPoint(text: "Extended benefits for cardholders traveling abroad (e.g., lost luggage or emergency cash).")
                        }
                        .padding()
                        .padding(.top, 40)
                        
                        Button {
                            
                        } label: {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.backgroundColorA)
                                .shadow(color: .gray.opacity(0.25), radius: 16, y: 5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(.gray.opacity(0.25), lineWidth: 1)
                                )
                                .overlay(
                                    Text("Continue")
                                        .foregroundStyle(Color.accentColorBrown)
                                        .font(AppFont.roboto(.semibold, size: 16))
                                        .shadow(color: .black.opacity(0.2), radius: 10, y: 5)
                                )
                                .frame(width: 300, height: 50)
                            
                        }
                        .padding(.top, 50)
                        
                        Color.clear.frame(height: 50)
                    }
                    .padding()
                    .background(
                        RoundedCorner(radius: 50, corners: [.topLeft, .topRight])
                            .fill(Color.white)
                            //.shadow(radius: 5)
                    )
                    .offset(y: 350)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }
}

#Preview {
    CardInsurance()
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
