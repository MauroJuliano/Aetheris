import SwiftUI

struct Underline: ViewModifier {
    var spacing: CGFloat = 6
    var height: CGFloat = 1
    var color: Color = .secondary

    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: spacing) {
            content
            Rectangle()
                .frame(height: height)
                .foregroundStyle(color)
        }
    }
}

extension View {
    func underlined(spacing: CGFloat = 6,
                    height: CGFloat = 1,
                    color: Color = .secondary) -> some View {
        modifier(Underline(spacing: spacing, height: height, color: color))
    }
}
