import AetherisDesignSystem
import SwiftUI

struct CurrentInvoiceDetailsSkeleton: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            SkeletonBlock(width: 150, height: 20, radius: 9)
                .padding(.horizontal, AppSpacing.medium)
                .padding(.top, AppSpacing.medium)
                .padding(.bottom, AppSpacing.small)

            ForEach(0..<4, id: \.self) { index in
                HStack(spacing: AppSpacing.medium) {
                    SkeletonView(.circle)
                        .frame(width: 42, height: 42)

                    VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                        SkeletonBlock(width: index == 3 ? 110 : 145, height: 16, radius: 8)
                        if index < 3 {
                            SkeletonBlock(width: 175, height: 13, radius: 6)
                        }
                    }

                    Spacer()

                    SkeletonBlock(width: 76, height: 17, radius: 8)
                }
                .padding(.horizontal, AppSpacing.medium)
                .padding(.vertical, AppSpacing.small)

                if index < 3 {
                    Divider()
                        .padding(.leading, 72)
                }
            }
        }
        .appCardSurface()
    }
}

#Preview {
    CurrentInvoiceDetailsSkeleton()
        .padding()
        .appScreenBackground()
}
