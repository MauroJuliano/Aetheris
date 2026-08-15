import AetherisDesignSystem
import SwiftUI

struct HomeQuickActions: View {
    let actions: [CardOptions]
    let onAction: (CardOptions) -> Void

    var body: some View {
        HStack(spacing: AppSpacing.small) {
            ForEach(actions.prefix(4)) { option in
                quickActionButton(
                    option: option
                )
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, AppSpacing.medium)
        .padding(.horizontal, AppSpacing.small)
        .appCardSurface()
    }

    private func quickActionButton(option: CardOptions) -> some View {
        Button {
            onAction(option)
        } label: {
            VStack(spacing: AppSpacing.xSmall) {
                ZStack {
                    Circle()
                        .fill(Color.brandPrimaryColor.opacity(0.08))
                        .frame(
                            width: AppComponentMetrics.mediumCircleSize,
                            height: AppComponentMetrics.mediumCircleSize
                        )

                    Image(systemName: option.icon)
                        .font(.system(size: AppCardMetrics.cardButtonIconSize, weight: .regular))
                        .foregroundStyle(Color.brandPrimaryColor)
                }

                Text(option.label)
                    .font(AppTypography.cellCaption)
                    .bold()
                    .foregroundStyle(Color.textPrimary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(
                        maxWidth: .infinity,
                        minHeight: AppComponentMetrics.glassButtonLabelHeight,
                        alignment: .top
                    )
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HomeQuickActions(
        actions: [
            CardOptions(label: "Send", icon: "paperplane"),
            CardOptions(label: "Request", icon: "arrow.down"),
            .virtualCard(),
            .cardLock(isBlocked: false)
        ],
        onAction: { _ in }
    )
    .padding()
    .appScreenBackground()
}
