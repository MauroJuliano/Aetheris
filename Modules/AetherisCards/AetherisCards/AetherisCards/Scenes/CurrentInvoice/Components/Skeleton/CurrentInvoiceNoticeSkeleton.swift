import AetherisDesignSystem
import SwiftUI

struct CurrentInvoiceNoticeSkeleton: View {
    var body: some View {
        HStack(spacing: AppSpacing.medium) {
            SkeletonView(.circle)
                .frame(width: 48, height: 48)

            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                SkeletonBlock(width: 120, height: 17, radius: 8)
                SkeletonBlock(width: 220, height: 14, radius: 7)
            }

            Spacer()

            SkeletonBlock(width: 36, height: 36, radius: 18)
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }
}

#Preview {
    CurrentInvoiceNoticeSkeleton()
        .padding()
        .appScreenBackground()
}
