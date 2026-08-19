import SwiftUI

struct NotificationCellSkeleton: View {
    var body: some View {
        HStack(spacing: AppSpacing.medium - AppSpacing.xxxSmall) {
            SkeletonView(.circle)
                .frame(width: 46, height: 46)

            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                SkeletonBlock(width: 220, height: 16, radius: 8)
                SkeletonBlock(width: 160, height: 12, radius: 6)
            }

            Spacer()

            SkeletonBlock(width: 52, height: 14, radius: 7)
        }
        .appListCellRow(hasDivider: true)
    }
}

#Preview {
    NotificationCellSkeleton()
        .padding()
        .appScreenBackground()
}
