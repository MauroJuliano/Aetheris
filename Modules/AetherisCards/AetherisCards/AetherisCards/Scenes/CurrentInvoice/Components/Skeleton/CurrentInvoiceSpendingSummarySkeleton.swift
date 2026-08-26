import AetherisDesignSystem
import SwiftUI

struct CurrentInvoiceSpendingSummarySkeleton: View {
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium) {
            HStack {
                SkeletonBlock(width: 140, height: 20, radius: 9)

                Spacer()

                SkeletonBlock(width: 105, height: 34, radius: 12)
            }

            HStack(spacing: AppSpacing.large) {
                SkeletonView(.circle)
                    .frame(width: 112, height: 112)

                VStack(alignment: .leading, spacing: AppSpacing.small) {
                    SkeletonBlock(width: 130, height: 14, radius: 7)
                    SkeletonBlock(width: 110, height: 22, radius: 9)
                    SkeletonBlock(width: 180, height: 14, radius: 7)
                    SkeletonBlock(width: 170, height: 14, radius: 7)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }
}

#Preview {
    CurrentInvoiceSpendingSummarySkeleton()
        .padding()
        .appScreenBackground()
}
