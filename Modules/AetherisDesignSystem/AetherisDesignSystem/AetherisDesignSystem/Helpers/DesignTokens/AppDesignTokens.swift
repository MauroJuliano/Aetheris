import SwiftUI

public enum AppSpacing {
    public static let xxxSmall: CGFloat = 2
    public static let xxSmall: CGFloat = 4
    public static let xSmall: CGFloat = 8
    public static let small: CGFloat = 12
    public static let medium: CGFloat = 16
    public static let large: CGFloat = 20
    public static let xLarge: CGFloat = 24
    public static let xxLarge: CGFloat = 30
    public static let screenHorizontal: CGFloat = 16
    public static let formHorizontal: CGFloat = 35
    public static let listDividerLeading: CGFloat = 78
    public static let bottomBarClearance: CGFloat = 100
}

public enum AppRadius {
    public static let small: CGFloat = 8
    public static let medium: CGFloat = 12
    public static let large: CGFloat = 20
    public static let card: CGFloat = 24
    public static let pill: CGFloat = 30
}

public enum AppTypography {
    public static let caption = Font.caption
    public static let footnote = Font.footnote
    public static let body = Font.body
    public static let callout = Font.callout
    public static let subheadline = Font.subheadline
    public static let headline = Font.headline
    public static let sectionTitle = Font.headline
    public static let screenTitle = Font.largeTitle
    public static let heroTitle = Font.system(size: 34, weight: .bold)
    public static let navTitle = Font.system(size: 22, weight: .medium)
    public static let button = Font.system(size: 16, weight: .semibold)
    public static let cardBody = Font.system(size: 16, weight: .regular)
}

public struct AppShadowStyle {
    let color: Color
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat

    public init(color: Color, radius: CGFloat, x: CGFloat = 0, y: CGFloat = 0) {
        self.color = color
        self.radius = radius
        self.x = x
        self.y = y
    }
}

public enum AppShadow {
    public static let none = AppShadowStyle(color: .clear, radius: 0)
    public static let soft = AppShadowStyle(color: .black.opacity(0.08), radius: 24, y: 12)
    public static let card = AppShadowStyle(color: .gray.opacity(0.25), radius: 16, y: 5)
    public static let elevated = AppShadowStyle(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
    public static let control = AppShadowStyle(color: .black.opacity(0.2), radius: 10, y: 5)
}

public extension View {
    func appShadow(_ style: AppShadowStyle) -> some View {
        shadow(color: style.color, radius: style.radius, x: style.x, y: style.y)
    }

    func appCardSurface(
        radius: CGFloat = AppRadius.card,
        fill: Color = .backgroundColorA,
        stroke: Color? = nil,
        shadow: AppShadowStyle = AppShadow.soft
    ) -> some View {
        background(
            RoundedRectangle(cornerRadius: radius, style: .continuous)
                .fill(fill)
                .appShadow(shadow)
                .overlay {
                    if let stroke {
                        RoundedRectangle(cornerRadius: radius, style: .continuous)
                            .stroke(stroke, lineWidth: 1)
                    }
                }
        )
    }

    func appScreenBackground() -> some View {
        background(Color.backgroundColorA)
    }

    func appListCellPadding(
        horizontal: CGFloat = AppSpacing.medium + AppSpacing.xxxSmall,
        vertical: CGFloat = AppSpacing.medium + AppSpacing.xxxSmall
    ) -> some View {
        padding(.horizontal, horizontal)
            .padding(.vertical, vertical)
    }

    @ViewBuilder
    func appListCellRow(
        hasDivider: Bool,
        dividerLeading: CGFloat = AppSpacing.listDividerLeading,
        horizontalPadding: CGFloat = AppSpacing.medium + AppSpacing.xxxSmall,
        verticalPadding: CGFloat = AppSpacing.medium + AppSpacing.xxxSmall
    ) -> some View {
        VStack(spacing: 0) {
            appListCellPadding(horizontal: horizontalPadding, vertical: verticalPadding)

            if hasDivider {
                Divider()
                    .padding(.leading, dividerLeading)
            }
        }
    }
}
