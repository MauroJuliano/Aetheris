import SwiftUI

struct GlowButtonSkeleton: View {
    var body: some View {
        SkeletonBlock(width: AppComponentMetrics.glowButtonWidth, height: AppComponentMetrics.glowButtonHeight, radius: AppRadius.pill)
    }
}

#Preview {
    GlowButtonSkeleton()
        .padding()
        .appScreenBackground()
}
