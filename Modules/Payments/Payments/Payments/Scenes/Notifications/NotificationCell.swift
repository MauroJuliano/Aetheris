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
        let formatter = DateFormatter()
        
        if Calendar.current.isDateInToday(model.date) {
            formatter.dateFormat = "h:mm a"
            return formatter.string(from: model.date)
        }
        
        if Calendar.current.isDateInYesterday(model.date) {
            return "Yesterday"
        }
        
        let days = Calendar.current.dateComponents([.day],
                                                   from: model.date,
                                                   to: Date()).day ?? 0
        
        if days < 30 {
            return "\(days) days ago"
        }
        
        return "\(max(1, days / 30)) month ago"
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
    NotificationCell(model: .mock.first!)
}
