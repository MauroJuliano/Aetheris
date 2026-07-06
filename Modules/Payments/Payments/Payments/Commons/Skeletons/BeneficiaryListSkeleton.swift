import AetherisDesignSystem
import SwiftUI

struct BeneficiaryListSkeleton: View {
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                Spacer()
                    .frame(height: AppSpacing.bottomBarClearance / 2)

                VStack(spacing: 0) {
                    ForEach(0..<4, id: \.self) { index in
                        HStack(spacing: AppSpacing.medium - AppSpacing.xxxSmall) {
                            SkeletonView(.circle)
                                .frame(width: 46, height: 46)

                            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                                SkeletonBlock(width: nameWidth(for: index), height: 16, radius: 8)
                                SkeletonBlock(width: keyWidth(for: index), height: 12, radius: 6)
                            }

                            Spacer()

                            SkeletonView(.circle)
                                .frame(width: 50, height: 50)
                        }
                        .appListCellRow(hasDivider: index < 3)
                    }
                }
                .appCardSurface(
                    radius: AppRadius.large,
                    stroke: Color.border,
                    shadow: AppShadow.card
                )
            }
            .appScreenBackground()
        }
        .appScreenBackground()
    }

    private func nameWidth(for index: Int) -> CGFloat {
        switch index {
        case 0:
            return 78
        case 1:
            return 104
        case 2:
            return 64
        default:
            return 118
        }
    }

    private func keyWidth(for index: Int) -> CGFloat {
        switch index {
        case 0:
            return 210
        case 1:
            return 92
        case 2:
            return 128
        default:
            return 76
        }
    }

}

#Preview {
    BeneficiaryListSkeleton()
        .padding(.horizontal)
}
