import AetherisDesignSystem
import SwiftUI

struct VirtualCardStatusView: View {
    let isActive: Bool
    let isLoading: Bool
    let onStatusChange: (Bool) -> Void

    var body: some View {
        HStack(spacing: AppSpacing.medium) {
            statusIcon

            VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
                Text(isActive ? Strings.VirtualCard.activeTitle : Strings.VirtualCard.inactiveTitle)
                    .font(AppTypography.body)
                    .bold()
                    .foregroundStyle(Color.textPrimary)

                Text(isActive ? Strings.VirtualCard.activeDescription : Strings.VirtualCard.inactiveDescription)
                    .font(AppTypography.cellCaption)
                    .foregroundStyle(Color.textSecondaryColor)
            }

            Spacer()

            if isLoading {
                ProgressView()
                    .tint(Color.brandPrimaryColor)
                    .frame(width: 52)
            } else {
                Toggle(
                    "",
                    isOn: Binding(
                        get: { isActive },
                        set: { onStatusChange($0) }
                    )
                )
                .labelsHidden()
                .tint(Color.brandPrimaryColor)
            }
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }

    private var statusIcon: some View {
        ZStack {
            Circle()
                .fill(Color.brandPrimaryColor.opacity(0.08))
                .frame(width: 48, height: 48)

            Image(systemName: isActive ? "checkmark.shield" : "lock.shield")
                .font(.system(size: 22, weight: .medium))
                .foregroundStyle(Color.brandPrimaryColor)
        }
    }
}
