import SwiftUI

struct CreditCardView: View {
    @State var model: CreditCardModel
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.blue.opacity(0.4), Color.purple.opacity(0.4)],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(width: 360, height: 220) // slightly bigger than card
            .blur(radius: 20)
            .offset(y: 5)
            
            ZStack {
                
                // Base gradient
                LinearGradient(
                    colors: [Color.blue, Color.purple],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                // Decorative ellipses
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.1))
                        .frame(width: 300, height: 300)
                        .offset(x: -170, y: 110)
                    
                    Circle()
                        .fill(Color.black.opacity(0.15))
                        .frame(width: 350, height: 350)
                        .offset(x: 190, y: 150)
                    
                    Circle()
                        .fill(Color.purple.opacity(0.3))
                        .frame(width: 250, height: 250)
                        .offset(x: 190, y: -60)
                }
                
                // Card contents
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Image(systemName: "bolt.fill") // top-left icon
                        Spacer()
                        Image(systemName: "wave.3.right") // top-right contactless
                    }
                    .foregroundColor(.white)
                    
                    Text(model.number)
                        .font(.title2.monospaced())
                        .foregroundColor(.white)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Valid till")
                                .font(.caption2)
                                .foregroundColor(.white.opacity(0.7))
                            Text(model.validDate)
                                .bold()
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                    
                    HStack {
                        Text(model.name)
                            .bold()
                            .foregroundColor(.white)
                        Spacer()
                        Text(model.brand)
                            .bold()
                            .foregroundColor(.white)
                    }
                }
                .padding(AppSpacing.xLarge)
            }
            .frame(width: 340, height: 200)  // ✅ constrain the whole card
            .clipShape(RoundedRectangle(cornerRadius: AppRadius.large)) // ✅ keeps proportions
            .shadow(color: .purple.opacity(0.15), radius: 10)
        }
        
        
    }
}

#Preview {
    
    let model = CreditCardModel(number: "XXXX XXXX XXXX XX27",
                                validDate: "09/24",
                                name: "Jorge henrique",
                                brand: "VISA")
    CreditCardView(model: model)
}
