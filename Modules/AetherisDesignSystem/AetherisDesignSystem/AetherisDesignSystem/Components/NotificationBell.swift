import SwiftUI

public struct NotificationBell: View {
    public var body: some View {
        ZStack {
            Image(systemName: "bell")
                .font(.system(size: 24))
                .tint(Color.textTertiary)
            
            Circle()
                .fill(Color.brandPrimaryColor)
                .frame(width: AppComponentMetrics.notificationBadgeSize, height: AppComponentMetrics.notificationBadgeSize)
                .offset(x: 5, y: -5)
        }
    }
}

