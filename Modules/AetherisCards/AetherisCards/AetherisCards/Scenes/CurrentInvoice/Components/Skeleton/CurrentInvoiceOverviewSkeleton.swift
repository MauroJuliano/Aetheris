import AetherisDesignSystem
import SwiftUI

struct CurrentInvoiceOverviewSkeleton: View {
    var body: some View {
        ViewThatFits(in: .horizontal) {
            desktopOverview
            compactOverview
        }
        .appCardSurface()
    }

    private var desktopOverview: some View {
        HStack(alignment: .top, spacing: AppSpacing.medium) {
            overviewColumn

            Divider()
                .frame(height: 170)

            overviewColumn

            Divider()
                .frame(height: 170)

            overviewColumn
        }
        .padding(AppSpacing.medium)
    }

    private var compactOverview: some View {
        VStack(spacing: AppSpacing.medium) {
            HStack(alignment: .top, spacing: AppSpacing.medium) {
                overviewColumn

                Divider()
                    .frame(height: 154)

                overviewColumn
            }

            Divider()

            overviewColumn
        }
        .padding(AppSpacing.medium)
    }

    private var overviewColumn: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
            SkeletonBlock(width: 86, height: 13, radius: 6)
            SkeletonBlock(width: 100, height: 22, radius: 9)
            SkeletonBlock(width: 68, height: 13, radius: 6)

            Spacer(minLength: AppSpacing.medium)

            SkeletonBlock(width: 90, height: 13, radius: 6)
            SkeletonBlock(width: 80, height: 17, radius: 8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    CurrentInvoiceOverviewSkeleton()
        .padding()
        .appScreenBackground()
}
