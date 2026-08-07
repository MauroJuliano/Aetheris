import AetherisDesignSystem
import SwiftUI

struct VirtualCardQuickActions: View {
    let isGeneratingNewNumber: Bool
    let onCopyNumberTap: () -> Void
    let onGenerateNewNumberTap: () -> Void
    let onSettingsTap: () -> Void

    var body: some View {
        HStack(spacing: AppSpacing.small) {
            actionButton(title: Strings.VirtualCard.copyNumber, icon: "doc.on.doc", action: onCopyNumberTap)

            actionButton(
                title: Strings.VirtualCard.generateNewNumber,
                icon: "arrow.clockwise",
                isLoading: isGeneratingNewNumber,
                action: onGenerateNewNumberTap
            )

            actionButton(title: Strings.VirtualCard.settings, icon: "gearshape", action: onSettingsTap)
        }
        .padding(.horizontal, AppSpacing.small)
        .padding(.vertical, AppSpacing.medium)
        .appCardSurface()
    }

    private func actionButton(
        title: String,
        icon: String,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            VStack(spacing: AppSpacing.xSmall) {
                ZStack {
                    Circle()
                        .fill(Color.brandPrimaryColor.opacity(0.08))
                        .frame(
                            width: AppComponentMetrics.mediumCircleSize,
                            height: AppComponentMetrics.mediumCircleSize
                        )

                    if isLoading {
                        ProgressView()
                            .tint(Color.brandPrimaryColor)
                    } else {
                        Image(systemName: icon)
                            .font(.system(size: AppCardMetrics.cardButtonIconSize, weight: .regular))
                            .foregroundStyle(Color.brandPrimaryColor)
                    }
                }

                Text(title)
                    .font(AppTypography.cellCaption)
                    .bold()
                    .foregroundStyle(Color.textPrimary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .frame(height: AppComponentMetrics.glassButtonLabelHeight)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(isLoading)
    }
}
