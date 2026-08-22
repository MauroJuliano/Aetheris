import SwiftUI

struct NotificationSectionHeaderSkeleton: View {
    let width: CGFloat

    var body: some View {
        SkeletonBlock(
            width: width,
            height: 18,
            radius: 9
        )
    }
}

#Preview {
    NotificationSectionHeaderSkeleton(width: 72)
        .padding()
        .appScreenBackground()
}
