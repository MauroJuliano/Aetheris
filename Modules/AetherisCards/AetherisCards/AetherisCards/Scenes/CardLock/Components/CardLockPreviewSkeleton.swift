import AetherisDesignSystem
import SwiftUI

struct CardLockPreviewSkeleton: View {
    var body: some View {
        SkeletonBlock(height: 210, radius: AppRadius.card)
            .aspectRatio(1.58, contentMode: .fit)
    }
}
