import SwiftUI

public struct StatusToggleCard: View {
    public let title: String
    public let description: String
    public let icon: String
    public let isOn: Bool
    public let isUpdating: Bool
    public let onChange: (Bool) -> Void

    public init(title: String, description: String, icon: String, isOn: Bool, isUpdating: Bool = false, onChange: @escaping (Bool) -> Void) {
        self.title = title
        self.description = description
        self.icon = icon
        self.isOn = isOn
        self.isUpdating = isUpdating
        self.onChange = onChange
    }

    public var body: some View {
        HStack(spacing: AppSpacing.medium) {
            ZStack {
                Circle().fill(Color.brandPrimaryColor.opacity(0.08)).frame(width: 48, height: 48)
                Image(systemName: icon).font(.system(size: 22, weight: .medium)).foregroundStyle(Color.brandPrimaryColor)
            }
            VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
                Text(title).font(AppTypography.body).bold().foregroundStyle(Color.textPrimary)
                Text(description).font(AppTypography.cellCaption).foregroundStyle(Color.textSecondaryColor)
            }
            Spacer()
            if isUpdating {
                ProgressView().tint(Color.brandPrimaryColor).frame(width: 52)
            } else {
                Toggle("", isOn: Binding(get: { isOn }, set: onChange)).labelsHidden().tint(Color.brandPrimaryColor)
            }
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(title)
        .accessibilityValue(description)
        .accessibilityAddTraits(.isButton)
        .accessibilityAction {
            guard !isUpdating else { return }
            onChange(!isOn)
        }
    }

    @ViewBuilder
    public func toSkeleton(enable: Bool) -> some View {
        if enable { StatusToggleCardSkeleton() } else { self }
    }
}
