import SwiftUI

struct CreditCardView: View {
    let model: CreditCardModel
    let theme: CreditCardTheme

    init(model: CreditCardModel, theme: CreditCardTheme) {
        self.model = model
        self.theme = theme
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: theme.glow,
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(width: AppCreditCardStyle.glowSize.width, height: AppCreditCardStyle.glowSize.height)
            .blur(radius: AppCreditCardStyle.glowBlur)
            .offset(y: AppCreditCardStyle.glowOffsetY)
            
            ZStack {
                
                // Base gradient
                LinearGradient(
                    colors: theme.gradient,
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
                        .fill(theme.accentOverlay)
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
                    .foregroundColor(theme.foreground)
                    
                    Text(model.number)
                        .font(.title2.monospaced())
                        .foregroundColor(theme.foreground)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text(Strings.CreditCard.validTill)
                                .font(.caption2)
                                .foregroundColor(theme.secondaryForeground)
                            Text(model.validDate)
                                .bold()
                                .foregroundColor(theme.foreground)
                        }
                        Spacer()
                    }
                    
                    HStack {
                        Text(model.name)
                            .bold()
                            .foregroundColor(theme.foreground)
                        Spacer()
                        Text(model.brand)
                            .bold()
                            .foregroundColor(theme.foreground)
                    }
                }
                .padding(AppSpacing.xLarge)
            }
            .frame(width: AppCardMetrics.creditCardSize.width, height: AppCardMetrics.creditCardSize.height)
            .clipShape(RoundedRectangle(cornerRadius: AppCardMetrics.creditCardBorderRadius))
            .appShadow(AppShadowStyle(color: theme.shadow, radius: 10))
        }
        
        
    }
}
