import AetherisDesignSystem
import SwiftUI

struct VirtualCardUsageSummarySkeleton: View {
    var body: some View {
        HStack(alignment: .top, spacing: AppSpacing.medium) {
            usageColumn

            Divider()
                .frame(height: 100)

            usageColumn
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }

    private var usageColumn: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
            SkeletonBlock(width: 110, height: 14, radius: 7)
            SkeletonBlock(width: 120, height: 22, radius: 9)
            SkeletonBlock(width: 130, height: 8, radius: 4)
            SkeletonBlock(width: 100, height: 14, radius: 7)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    VirtualCardUsageSummarySkeleton()
        .padding()
        .appScreenBackground()
}
