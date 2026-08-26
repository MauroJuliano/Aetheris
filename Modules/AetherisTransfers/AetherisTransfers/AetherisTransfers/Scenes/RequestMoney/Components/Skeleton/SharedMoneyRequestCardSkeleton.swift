import AetherisDesignSystem
import SwiftUI

struct SharedMoneyRequestCardSkeleton: View {
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.large) {
            SkeletonBlock(width: 190, height: 16, radius: 8)

            SkeletonBlock(height: 66, radius: AppRadius.medium)

            HStack {
                ForEach(0..<4, id: \.self) { _ in
                    SkeletonBlock(width: 76, height: 42, radius: 21)
                }
            }

            SkeletonBlock(width: 120, height: 16, radius: 8)
            SkeletonBlock(height: 56, radius: AppRadius.medium)

            SkeletonBlock(width: 160, height: 16, radius: 8)
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }
}

#Preview {
    SharedMoneyRequestCardSkeleton()
        .padding()
        .appScreenBackground()
}
