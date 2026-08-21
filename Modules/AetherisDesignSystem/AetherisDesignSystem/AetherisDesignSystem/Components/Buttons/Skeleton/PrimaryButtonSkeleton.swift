import SwiftUI

struct PrimaryButtonSkeleton: View {
    var body: some View {
        SkeletonBlock(height: 50, radius: AppRadius.large)
            .frame(maxWidth: .infinity)
    }
}

#Preview {
    PrimaryButtonSkeleton()
        .padding()
        .appScreenBackground()
}
