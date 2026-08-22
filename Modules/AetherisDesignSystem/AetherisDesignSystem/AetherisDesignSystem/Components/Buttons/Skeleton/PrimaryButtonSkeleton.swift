import SwiftUI

struct PrimaryButtonSkeleton: View {
    var body: some View {
        SkeletonBlock(width: 180, height: 50, radius: AppRadius.large)
    }
}

#Preview {
    PrimaryButtonSkeleton()
        .padding()
        .appScreenBackground()
}
