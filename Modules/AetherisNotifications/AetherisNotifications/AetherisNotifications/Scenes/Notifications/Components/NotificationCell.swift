import AetherisDesignSystem
import SwiftUI

public struct NotificationCell: View {
    var model: Notifications
    
    public var body: some View {
        HStack(spacing: AppSpacing.medium - AppSpacing.xxxSmall) {
            leadingView

            Text(model.title)
                .font(AppTypography.callout)
                .foregroundStyle(Color.textPrimary)
                .bold()
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: AppSpacing.xSmall) {
                Circle()
                    .fill(Color.brandPrimaryColor)
                    .frame(width: AppSpacing.xSmall, height: AppSpacing.xSmall)

                Text(timeLabel)
                    .font(AppTypography.footnote)
                    .foregroundStyle(Color.textTertiary)
            }
        }
        .appListCellRow(hasDivider: model.hasDivider)
    }
    
    private var timeLabel: String {
        NotificationTimeLabelFormatter.label(for: model.date)
    }
    
    @ViewBuilder
    private var leadingView: some View {
        switch model.leadingContent {
        case .image(let name):
            Image(name)
                .resizable()
                .scaledToFill()
                .frame(width: 46, height: 46)
                .clipShape(Circle())

        case .icon(let systemName):
            Circle()
                .fill(Color.brandPrimaryColor.opacity(0.12))
                .frame(width: 46, height: 46)
                .overlay {
                    Image(systemName: systemName)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(Color.brandPrimaryColor)
                }
        }
    }
}

#Preview {
    NotificationCell(
        model: Notifications(
            title: "Payment received from Sophie",
            leadingContent: .image("sophie"),
            date: Date(),
            hasDivider: false
        )
    )
    .padding()
    .appScreenBackground()
}
