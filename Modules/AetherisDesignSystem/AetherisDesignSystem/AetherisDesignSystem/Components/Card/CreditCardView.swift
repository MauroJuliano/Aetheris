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
            .frame(width: AppCreditCardStyle.glowSize.width, height: AppCreditCardStyle.glowSize.height)
            .blur(radius: AppCreditCardStyle.glowBlur)
            .offset(y: AppCreditCardStyle.glowOffsetY)
            
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
                        .fill(AppCreditCardStyle.lightOverlay)
                        .frame(width: AppCardMetrics.creditCardOverlayOneSize, height: AppCardMetrics.creditCardOverlayOneSize)
                        .offset(x: -170, y: 110)
                    
                    Circle()
                        .fill(AppCreditCardStyle.darkOverlay)
                        .frame(width: AppCardMetrics.creditCardOverlayTwoSize, height: AppCardMetrics.creditCardOverlayTwoSize)
                        .offset(x: 190, y: 150)
                    
                    Circle()
                        .fill(AppCreditCardStyle.accentOverlay)
                        .frame(width: AppCardMetrics.creditCardOverlayThreeSize, height: AppCardMetrics.creditCardOverlayThreeSize)
                        .offset(x: 190, y: -60)
                }
                
                // Card contents
                VStack(alignment: .leading, spacing: AppCreditCardStyle.contentSpacing) {
                    HStack {
                        Image(systemName: "bolt.fill") // top-left icon
                        Spacer()
                        Image(systemName: "wave.3.right") // top-right contactless
                    }
                    .foregroundColor(AppCreditCardStyle.foreground)
                    
                    Text(model.number)
                        .font(.title2.monospaced())
                        .foregroundColor(AppCreditCardStyle.foreground)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Valid till")
                                .font(.caption2)
                                .foregroundColor(AppCreditCardStyle.secondaryForeground)
                            Text(model.validDate)
                                .bold()
                                .foregroundColor(AppCreditCardStyle.foreground)
                        }
                        Spacer()
                    }
                    
                    HStack {
                        Text(model.name)
                            .bold()
                            .foregroundColor(AppCreditCardStyle.foreground)
                        Spacer()
                        Text(model.brand)
                            .bold()
                            .foregroundColor(AppCreditCardStyle.foreground)
                    }
                }
                .padding(AppSpacing.xLarge)
            }
            .frame(width: AppCardMetrics.creditCardSize.width, height: AppCardMetrics.creditCardSize.height)
            .clipShape(RoundedRectangle(cornerRadius: AppCardMetrics.creditCardBorderRadius))
            .appShadow(AppCreditCardStyle.shadow)
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
