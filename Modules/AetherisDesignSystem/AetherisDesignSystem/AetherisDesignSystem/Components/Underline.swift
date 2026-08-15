import SwiftUI

public struct Underline: ViewModifier {
    var spacing: CGFloat = 6
    var height: CGFloat = 1
    var color: Color = .secondary

    init(spacing: CGFloat, height: CGFloat, color: Color) {
        self.spacing = spacing
        self.height = height
        self.color = color
    }
    
    public func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: spacing) {
            content
            Rectangle()
                .frame(height: height)
                .foregroundStyle(color)
        }
    }
}

public extension View {
    func underlined(spacing: CGFloat = 6,
                    height: CGFloat = 1,
                    color: Color = .secondary) -> some View {
        modifier(Underline(spacing: spacing, height: height, color: color))
    }
}

#Preview {
    Text("Underlined text")
        .font(AppTypography.headline)
        .foregroundStyle(Color.textPrimary)
        .underlined(
            spacing: AppSpacing.xSmall,
            height: 2,
            color: .brandPrimaryColor
        )
        .padding()
        .appScreenBackground()
}
