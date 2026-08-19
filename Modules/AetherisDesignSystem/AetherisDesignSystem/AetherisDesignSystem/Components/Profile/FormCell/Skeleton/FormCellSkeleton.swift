import SwiftUI

struct FormCellSkeleton: View {
    let hasSectionTitle: Bool
    let hasDivider: Bool
    let showsToggle: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
            if hasSectionTitle {
                SkeletonBlock(width: 120, height: 20, radius: 9)
                    .padding(.top)
            }

            HStack {
                SkeletonView(Rectangle())
                    .frame(width: AppComponentMetrics.smallCircleSize, height: AppComponentMetrics.smallCircleSize)

                SkeletonBlock(width: 140, height: 16, radius: 8)

                Spacer()

                if showsToggle {
                    SkeletonBlock(width: 44, height: 28, radius: 14)
                } else {
                    SkeletonBlock(width: 10, height: 16, radius: 5)
                }
            }
        }
        .padding(.vertical, AppSpacing.xSmall)
        .overlay(alignment: .bottom) {
            if hasDivider {
                Divider()
            }
        }
    }
}

#Preview {
    VStack(spacing: 0) {
        FormCellSkeleton(hasSectionTitle: true, hasDivider: true, showsToggle: false)
        FormCellSkeleton(hasSectionTitle: false, hasDivider: false, showsToggle: true)
    }
    .padding()
    .appScreenBackground()
}
