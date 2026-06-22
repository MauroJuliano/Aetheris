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
            VStack {
                
                ZStack {
                    ZStack {
                           Color.purple.opacity(0.3)
                           BlurView(style: .systemUltraThinMaterial)
                       }
                       .frame(width: 60, height: 60)
                       .clipShape(Circle())
                       .overlay(Circle().stroke(.white.opacity(0.25), lineWidth: 1))
                    
                    
                    Image(systemName: model.icon)
                        .font(.title)
                        .foregroundStyle(.white)
                        .frame(width: 20, height: 20)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                }
                
                
                Text(model.label)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.gray)
                    .font(AppFont.roboto(.regular, size: 16))
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

