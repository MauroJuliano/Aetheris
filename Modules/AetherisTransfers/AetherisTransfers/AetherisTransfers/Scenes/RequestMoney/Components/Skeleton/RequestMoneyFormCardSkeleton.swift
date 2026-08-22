import AetherisDesignSystem
import SwiftUI

struct RequestMoneyFormCardSkeleton: View {
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.large) {
            SkeletonBlock(width: 200, height: 16, radius: 8)

            recipientSelectionSkeleton

            HStack(spacing: AppSpacing.medium) {
                ForEach(0..<4, id: \.self) { _ in
                    VStack(spacing: AppSpacing.small) {
                        SkeletonView(.circle)
                            .frame(width: 58, height: 58)

                        SkeletonBlock(width: 52, height: 13, radius: 6)
                    }
                    .frame(width: 72)
                }
            }

            Divider()

            SkeletonBlock(width: 190, height: 16, radius: 8)
            SkeletonBlock(width: 170, height: 38, radius: 12)

            HStack {
                ForEach(0..<4, id: \.self) { _ in
                    SkeletonBlock(width: 76, height: 42, radius: 21)
                }
            }

            SkeletonBlock(width: 120, height: 16, radius: 8)
            SkeletonBlock(height: 56, radius: AppRadius.medium)
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }

    private var recipientSelectionSkeleton: some View {
        HStack(spacing: AppSpacing.small) {
            SkeletonView(.circle)
                .frame(width: 42, height: 42)

            VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
                SkeletonBlock(width: 180, height: 14, radius: 7)
                SkeletonBlock(width: 128, height: 12, radius: 6)
            }

            Spacer()

            SkeletonBlock(width: 12, height: 20, radius: 6)
        }
        .padding(.horizontal, AppSpacing.medium)
        .frame(height: 66)
        .background(Color.surface.opacity(0.7))
        .overlay {
            RoundedRectangle(cornerRadius: AppRadius.medium)
                .stroke(Color.textTertiary.opacity(0.25))
        }
    }
}
