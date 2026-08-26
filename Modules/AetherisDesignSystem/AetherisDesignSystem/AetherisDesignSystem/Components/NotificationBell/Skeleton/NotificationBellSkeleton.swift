import SwiftUI

struct NotificationBellSkeleton: View {
    var body: some View {
        SkeletonView(.circle)
            .frame(width: 24, height: 24)
    }
}

#Preview {
    NotificationBellSkeleton()
        .padding()
        .appScreenBackground()
}
