import SwiftUI

struct QuickActionsSkeleton: View {
    let titleWidth: CGFloat
    let actionsCount: Int

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium + AppSpacing.xxxSmall) {
            SkeletonBlock(width: titleWidth, height: 18, radius: 9)

            HStack(spacing: AppSpacing.medium) {
                ForEach(0..<actionsCount, id: \.self) { _ in
                    VStack(alignment: .leading, spacing: AppSpacing.medium) {
                        HStack {
                            SkeletonView(.circle)
                                .frame(width: 36, height: 36)
                            Spacer()
                        }

                        Spacer(minLength: AppSpacing.small)

                        VStack(alignment: .leading, spacing: AppSpacing.xxSmall) {
                            SkeletonBlock(width: 82, height: 14, radius: 7)
                            SkeletonBlock(width: 100, height: 12, radius: 6)
                        }
                        .frame(height: 36, alignment: .bottom)
                    }
                    .padding(.horizontal, AppSpacing.large)
                    .padding(.vertical, AppSpacing.medium)
                    .frame(maxWidth: .infinity)
                    .frame(height: 132)
                    .background(
                        RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                            .fill(Color.surface)
                    )
                }
            }
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }
}

#Preview {
    QuickActionsSkeleton(titleWidth: 190, actionsCount: 3)
        .padding()
        .appScreenBackground()
}
