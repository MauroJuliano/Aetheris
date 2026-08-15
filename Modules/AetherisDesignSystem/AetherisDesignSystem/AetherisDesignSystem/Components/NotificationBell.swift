import SwiftUI

public struct NotificationBell: View {
    private let showBadge: Bool

    public init(showBadge: Bool = true) {
        self.showBadge = showBadge
    }

    public var body: some View {
        ZStack {
            Image(systemName: "bell")
                .font(.system(size: 24))
                .tint(Color.textTertiary)
            
            if showBadge {
                Circle()
                    .fill(Color.brandPrimaryColor)
                    .frame(width: AppComponentMetrics.notificationBadgeSize, height: AppComponentMetrics.notificationBadgeSize)
                    .offset(x: 5, y: -5)
            }
        }
    }
}

#Preview {
    HStack(spacing: AppSpacing.large) {
        NotificationBell(showBadge: true)
        NotificationBell(showBadge: false)
    }
    .padding()
    .appScreenBackground()
}
