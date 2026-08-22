import SwiftUI

struct RecipientsContainerSkeleton: View {
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium + AppSpacing.xxxSmall) {
            HStack {
                SkeletonBlock(width: 90, height: 18, radius: 9)

                Spacer()

                SkeletonBlock(width: 52, height: 16, radius: 8)
            }

            HStack(spacing: AppSpacing.xLarge) {
                ForEach(0..<4, id: \.self) { _ in
                    VStack(spacing: AppSpacing.xSmall) {
                        SkeletonView(.circle)
                            .frame(width: 58, height: 58)

                        SkeletonBlock(width: 54, height: 13, radius: 6)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }
}

#Preview {
    RecipientsContainerSkeleton()
        .padding()
        .appScreenBackground()
}
