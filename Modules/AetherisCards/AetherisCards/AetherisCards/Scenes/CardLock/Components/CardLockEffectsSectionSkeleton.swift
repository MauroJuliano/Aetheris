import AetherisDesignSystem
import SwiftUI

struct CardLockEffectsSectionSkeleton: View {
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            SkeletonBlock(width: 150, height: 18, radius: 9)
            VStack(spacing: 0) {
                ForEach(0..<3, id: \.self) { _ in CardLockRowSkeleton() }
            }
            .appCardSurface()
        }
    }
}
