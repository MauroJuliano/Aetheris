import AetherisDesignSystem
import SwiftUI

struct SendMoneySkeleton: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: AppSpacing.large) {
                navigationBar
                beneficiary
                amount
                keyboard
                continueButton
            }
            .padding(.horizontal, AppSpacing.screenHorizontal)
            .padding(.top, AppSpacing.formTop)
        }
        .appScreenBackground()
        .accessibilityHidden(true)
    }

    private var navigationBar: some View {
        HStack(spacing: AppSpacing.medium) {
            SkeletonView(.circle)
                .frame(width: 40, height: 40)

            SkeletonBlock(width: 104, height: 24, radius: 12)

            Spacer()
        }
    }

    private var beneficiary: some View {
        HStack(spacing: AppSpacing.medium) {
            SkeletonView(.circle)
                .frame(width: 52, height: 52)

            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                SkeletonBlock(width: 112, height: 16, radius: 8)
                SkeletonBlock(width: 176, height: 12, radius: 6)
            }

            Spacer()

            SkeletonBlock(width: 58, height: 18, radius: 9)
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }

    private var amount: some View {
        VStack(spacing: AppSpacing.small) {
            SkeletonBlock(width: 94, height: 14, radius: 7)
            SkeletonBlock(width: 172, height: 42, radius: 18)
            SkeletonBlock(width: 126, height: 14, radius: 7)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, AppSpacing.medium)
    }

    private var keyboard: some View {
        VStack(spacing: AppSpacing.medium) {
            ForEach(0..<4, id: \.self) { _ in
                HStack(spacing: AppSpacing.large) {
                    ForEach(0..<3, id: \.self) { _ in
                        SkeletonView(.circle)
                            .frame(width: 58, height: 58)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        }
    }

    private var continueButton: some View {
        SkeletonBlock(width: 300, height: 50, radius: AppRadius.large)
            .padding(.top, AppSpacing.small)
    }
}
