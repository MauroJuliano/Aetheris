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
    public static let formTop: CGFloat = 60
    public static let controlHeight: CGFloat = 50
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
    public static let input = Font.body
    public static let cellTitle = Font.callout
    public static let cellSubtitle = Font.subheadline
    public static let cellCaption = Font.footnote
    public static let balanceAmount = Font.title
    public static let onboardingBody = Font.title3
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
    public static let tabBar = AppShadowStyle(color: .black.opacity(0.3), radius: 10, y: 5)
    public static let chartGlow = AppShadowStyle(color: .black.opacity(0.06), radius: 16, x: 8, y: 8)
}

public enum AppTabBarMetrics {
    public static let containerRadius: CGFloat = 25
    public static let selectedRadius: CGFloat = 20
    public static let containerWidth: CGFloat = 250
    public static let containerHeight: CGFloat = 50
    public static let selectedHeight: CGFloat = 40
    public static let itemWidth: CGFloat = 80
    public static let itemSpacing: CGFloat = 40
    public static let centerButtonSize: CGFloat = 50
    public static let itemLabelSpacing: CGFloat = 4
    public static let horizontalPadding: CGFloat = 16
    public static let bottomPadding: CGFloat = 20
}

public enum AppChartStyle {
    public static let tooltipHorizontalPadding: CGFloat = 8
    public static let tooltipVerticalPadding: CGFloat = 5
    public static let tooltipBackground = Color.gray.opacity(0.12)
    public static let markerSize: CGFloat = 10
}

public enum AppCreditCardStyle {
    public static let glowSize = AppCardMetrics.creditCardGlowSize
    public static let cardSize = AppCardMetrics.creditCardSize
    public static let glowBlur: CGFloat = 20
    public static let glowOffsetY: CGFloat = 5
    public static let contentSpacing: CGFloat = 20
    public static let foreground = Color.white
    public static let secondaryForeground = Color.white.opacity(0.7)
    public static let lightOverlay = Color.white.opacity(0.1)
    public static let darkOverlay = Color.black.opacity(0.15)
    public static let accentOverlay = Color.purple.opacity(0.3)
    public static let shadow = AppShadowStyle(color: .purple.opacity(0.15), radius: 10)
}

public enum AppBadgeStyle {
    public static let horizontalPadding: CGFloat = 8
    public static let verticalPadding: CGFloat = 5
    public static let iconSize: CGFloat = 9
    public static let font = Font.system(size: 11, weight: .semibold)
}

public enum AppComponentMetrics {
    public static let navigationIconButtonSize: CGFloat = 40
    public static let navigationChevronSize = CGSize(width: 10, height: 20)
    public static let notificationBadgeSize: CGFloat = 10
    public static let smallCircleSize: CGFloat = 28
    public static let mediumCircleSize: CGFloat = 58
    public static let largeCircleSize: CGFloat = 120
    public static let avatarImageSize: CGFloat = 150
    public static let tabBarContainerWidth: CGFloat = 250
    public static let tabBarContainerHeight: CGFloat = 50
    public static let tabBarSelectionHeight: CGFloat = 40
    public static let tabBarItemWidth: CGFloat = 80
    public static let tabBarSpacing: CGFloat = 40
    public static let tabBarBottomPadding: CGFloat = 20
    public static let tabBarHorizontalPadding: CGFloat = 16
    public static let tabBarCenterButtonSize: CGFloat = 50
    public static let keyboardContainerHorizontalPadding: CGFloat = 34
    public static let keyboardContainerTopPadding: CGFloat = 38
    public static let keyboardContainerBottomPadding: CGFloat = 28
    public static let keyboardKeySpacing: CGFloat = 16
    public static let keyboardRowSpacing: CGFloat = 14
    public static let keyboardKeyHeight: CGFloat = 58
    public static let keyboardKeyCornerRadius: CGFloat = 18
    public static let glowButtonWidth: CGFloat = 250
    public static let glowButtonHeight: CGFloat = 50
    public static let glassButtonLabelHeight: CGFloat = 32
    public static let listCellAvatarSize: CGFloat = 50
    public static let listCellIconSize = CGSize(width: 20, height: 25)
    public static let balanceEyeSize: CGFloat = 20
}

public enum AppCardMetrics {
    public static let swipeCardSize = CGSize(width: 350, height: 200)
    public static let infoCardSize = CGSize(width: 350, height: 200)
    public static let infoCardButtonSize = CGSize(width: 325, height: 40)
    public static let creditCardSize = CGSize(width: 340, height: 200)
    public static let creditCardGlowSize = CGSize(width: 360, height: 220)
    public static let creditCardOverlayOneSize: CGFloat = 300
    public static let creditCardOverlayTwoSize: CGFloat = 350
    public static let creditCardOverlayThreeSize: CGFloat = 250
    public static let creditCardBorderRadius: CGFloat = AppRadius.large
    public static let cardButtonIconSize: CGFloat = 20
}

public enum AppAvatarMetrics {
    public static let glowSize: CGFloat = 120
    public static let imageSize: CGFloat = 150
    public static let glowBlurRadius: CGFloat = 20
    public static let glowOffsetY: CGFloat = 5
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

    func appInputField(
        horizontalPadding: CGFloat = AppSpacing.formHorizontal,
        underlineColor: Color = Color.border
    ) -> some View {
        foregroundStyle(Color.textPrimary)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .underlined(color: underlineColor)
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, AppSpacing.xSmall)
    }

    func appIconButtonSurface(
        size: CGFloat = AppTabBarMetrics.centerButtonSize,
        radius: CGFloat = AppRadius.large,
        fill: Color = .surface,
        shadow: AppShadowStyle = AppShadow.control
    ) -> some View {
        frame(width: size, height: size)
            .background(
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .fill(fill)
                    .appShadow(shadow)
            )
    }

    func appCapsuleBadge(foreground: Color, background: Color) -> some View {
        foregroundStyle(foreground)
            .padding(.horizontal, AppBadgeStyle.horizontalPadding)
            .padding(.vertical, AppBadgeStyle.verticalPadding)
            .background(
                Capsule()
                    .fill(background)
            )
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
