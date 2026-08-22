import SwiftUI

struct AnalyticsCategorySummarySkeleton: View {
    let itemsCount: Int

    var body: some View {
        HStack(spacing: AppSpacing.medium) {
            ForEach(0..<itemsCount, id: \.self) { index in
                VStack(alignment: .center, spacing: AppSpacing.xxxSmall) {
                    SkeletonView(.rect)
                        .frame(width: 34, height: 34)
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 10,
                                style: .continuous
                            )
                        )

                    SkeletonBlock(width: index.isMultiple(of: 2) ? 48 : 42, height: 10, radius: 5)
                    SkeletonBlock(width: index.isMultiple(of: 3) ? 54 : 46, height: 12, radius: 6)
                    SkeletonBlock(width: index.isMultiple(of: 2) ? 28 : 24, height: 10, radius: 5)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}
