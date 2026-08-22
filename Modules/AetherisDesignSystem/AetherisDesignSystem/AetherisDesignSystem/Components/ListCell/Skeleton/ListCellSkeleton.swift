import SwiftUI

struct ListCellSkeleton: View {
    var body: some View {
        HStack {
            SkeletonView(Rectangle())
                .frame(width: AppComponentMetrics.listCellAvatarSize, height: AppComponentMetrics.listCellAvatarSize)

            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                SkeletonBlock(width: 120, height: 16, radius: 8)
                SkeletonBlock(width: 80, height: 12, radius: 6)
            }
            .padding(.horizontal, AppSpacing.screenHorizontal)

            Spacer()

            SkeletonBlock(width: 64, height: 18, radius: 9)
        }
        .padding(.horizontal, AppSpacing.screenHorizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ListCellSkeleton()
        .padding()
        .appScreenBackground()
}
