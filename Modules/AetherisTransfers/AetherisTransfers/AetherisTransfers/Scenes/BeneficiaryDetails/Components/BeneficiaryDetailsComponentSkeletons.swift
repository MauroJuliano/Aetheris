import AetherisDesignSystem
import SwiftUI

struct BeneficiaryProfileHeaderSkeleton: View {
    var body: some View {
        VStack(spacing: AppSpacing.medium) {
            SkeletonView(.circle).frame(width: 104, height: 104)
            SkeletonBlock(width: 160, height: 28, radius: 12)
            SkeletonBlock(width: 92, height: 30, radius: 15)
            HStack(spacing: AppSpacing.small) {
                ForEach(0..<3, id: \.self) { _ in
                    VStack(spacing: AppSpacing.xSmall) {
                        SkeletonView(.circle).frame(width: AppComponentMetrics.mediumCircleSize, height: AppComponentMetrics.mediumCircleSize)
                        SkeletonBlock(width: 65, height: 14, radius: 7)
                    }.frame(maxWidth: .infinity)
                }
            }
        }.padding(AppSpacing.large).appCardSurface()
    }
}

struct BeneficiaryInformationSectionSkeleton: View {
    var body: some View { skeletonSection(rows: 3, includesSummary: false) }
}

struct BeneficiaryTransactionsSectionSkeleton: View {
    var body: some View { skeletonSection(rows: 3, includesSummary: true) }
}

struct RemoveBeneficiaryButtonSkeleton: View {
    var body: some View {
        HStack(spacing: AppSpacing.medium) {
            SkeletonBlock(width: 28, height: 28, radius: 8)
            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                SkeletonBlock(width: 150, height: 17, radius: 8)
                SkeletonBlock(width: 240, height: 13, radius: 6)
            }
            Spacer()
        }.padding(AppSpacing.medium).appCardSurface()
    }
}

private func skeletonSection(rows: Int, includesSummary: Bool) -> some View {
    VStack(spacing: 0) {
        HStack { SkeletonBlock(width: 110, height: 20, radius: 9); Spacer() }.padding(AppSpacing.medium)
        if includesSummary {
            HStack { ForEach(0..<3, id: \.self) { _ in SkeletonBlock(width: 72, height: 40, radius: 8).frame(maxWidth: .infinity) } }.padding(AppSpacing.medium)
        }
        ForEach(0..<rows, id: \.self) { index in
            HStack(spacing: AppSpacing.medium) {
                SkeletonView(.circle).frame(width: 42, height: 42)
                VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                    SkeletonBlock(width: 140, height: 16, radius: 8)
                    SkeletonBlock(width: 190, height: 13, radius: 6)
                }
                Spacer()
            }.padding(AppSpacing.medium)
            if index < rows - 1 { Divider().padding(.leading, 56) }
        }
    }.appCardSurface()
}
