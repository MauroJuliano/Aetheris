import AetherisDesignSystem
import SwiftUI

struct AllServicesSkeleton: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: AppSpacing.large) {
                VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                    SkeletonBlock(width: 140, height: 18, radius: 9)
                    SkeletonBlock(width: 240, height: 14, radius: 7)
                }

                LazyVGrid(
                    columns: [
                        GridItem(.flexible(), spacing: AppSpacing.medium),
                        GridItem(.flexible(), spacing: AppSpacing.medium)
                    ],
                    spacing: AppSpacing.medium
                ) {
                    ForEach(0..<6, id: \.self) { index in
                        VStack(alignment: .leading, spacing: AppSpacing.medium) {
                            SkeletonView(.rect)
                                .frame(width: 44, height: 44)
                                .clipShape(RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous))

                            VStack(alignment: .leading, spacing: AppSpacing.xxSmall) {
                                SkeletonBlock(width: index.isMultiple(of: 2) ? 112 : 92, height: 16, radius: 8)
                                SkeletonBlock(width: index.isMultiple(of: 3) ? 128 : 102, height: 12, radius: 6)
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 132, alignment: .leading)
                        .padding(AppSpacing.medium)
                        .appCardSurface(
                            radius: AppRadius.large,
                            stroke: Color.border,
                            shadow: AppShadow.card
                        )
                    }
                }
            }
            .padding(.horizontal, AppSpacing.screenHorizontal)
            .padding(.top, AppSpacing.formTop)
            .padding(.bottom, AppSpacing.xxLarge)
        }
    }
}

#Preview {
    AllServicesSkeleton()
        .appScreenBackground()
}
