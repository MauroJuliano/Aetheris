import AetherisDesignSystem
import SwiftUI

struct RequestMoneyModeSelectorSkeleton: View {
    var body: some View {
        HStack(spacing: AppSpacing.xSmall) {
            SkeletonBlock(height: 48, radius: AppRadius.medium)
            SkeletonBlock(height: 48, radius: AppRadius.medium)
        }
        .padding(AppSpacing.xxxSmall)
        .appCardSurface()
    }
}

#Preview {
    RequestMoneyModeSelectorSkeleton()
        .padding()
        .appScreenBackground()
}
