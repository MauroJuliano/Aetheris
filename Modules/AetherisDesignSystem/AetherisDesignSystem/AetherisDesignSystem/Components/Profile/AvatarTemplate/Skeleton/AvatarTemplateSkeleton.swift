import SwiftUI

struct AvatarTemplateSkeleton: View {
    var body: some View {
        SkeletonView(.circle)
            .frame(width: AppAvatarMetrics.imageSize, height: AppAvatarMetrics.imageSize)
    }
}

#Preview {
    AvatarTemplateSkeleton()
        .padding()
        .appScreenBackground()
}
