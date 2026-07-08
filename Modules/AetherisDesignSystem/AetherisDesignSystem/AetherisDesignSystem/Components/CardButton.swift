import SwiftUI

public struct GlassButtonModel {
    var label: String
    var icon: String
    
    public init(label: String,
                icon: String) {
        self.label = label
        self.icon = icon
    }
}

public struct GlassButton: View {
    var model: GlassButtonModel
    var action: () -> Void
    
    public init(model: GlassButtonModel,
                action: @escaping () -> Void) {
        self.model = model
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            VStack(spacing: AppSpacing.xSmall) {
                ZStack {
                    Circle()
                        .fill(Color.brandPrimaryColor.opacity(0.08))
                        .frame(width: AppComponentMetrics.mediumCircleSize, height: AppComponentMetrics.mediumCircleSize)
                    
                    Image(systemName: model.icon)
                        .font(.system(size: AppCardMetrics.cardButtonIconSize, weight: .regular))
                        .foregroundStyle(Color.brandPrimaryColor)
                }
                
                Text(model.label)
                    .font(AppTypography.cellCaption)
                    .bold()
                    .foregroundStyle(Color.textPrimary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .frame(height: AppComponentMetrics.glassButtonLabelHeight)
                    
            }
        }
    }
}

// Blur helper
struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

struct GlassButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 16) {
            GlassButton(model: .init(label: "plus", icon: "plus")) {}
            GlassButton(model: .init(label: "plus", icon: "plus")) {}
            GlassButton(model: .init(label: "plus", icon: "plus")) {}
        }
        .padding()
        .background(Color("BackgroundGray"))
    }
}
