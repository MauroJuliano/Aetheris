import AetherisDesignSystem
import SwiftUI

public struct NotificationCell: View {
    var model: Notifications
    
    public var body: some View {
        VStack(spacing: 0) {
            
            HStack(spacing: 14) {
                leadingView

                Text(model.title)
                    .font(.callout)
                    .foregroundStyle(Color.textPrimary)
                    .bold()
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: 8) {
                    Circle()
                        .fill(Color.brandPrimaryColor)
                        .frame(width: 8, height: 8)

                    Text(timeLabel)
                        .font(.footnote)
                        .foregroundStyle(Color.textTertiary)
                }
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 18)
            
            if model.hasDivider {
                Divider()
                    .padding(.leading, 78)
            }
        }
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
