import SwiftUI

struct UserViewSkeleton: View {
    var body: some View {
        HStack {
            AvatarTemplateSkeleton()

            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                SkeletonBlock(width: 140, height: 16, radius: 8)
                SkeletonBlock(width: 120, height: 12, radius: 6)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    UserViewSkeleton()
        .padding()
        .appScreenBackground()
}
