import SwiftUI

struct CardDistributionSkeleton: View {
    let spectrumRatio: SpectrumRatio

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: AppRadius.large)
                .fill(Color.textTertiary.opacity(0.12))

            VStack {
                Spacer()

                HStack {
                    SkeletonView(.circle)
                        .frame(width: 24, height: 24)
                    Spacer()
                }

                Spacer()

                HStack {
                    SkeletonBlock(width: 90, height: 18, radius: 9)
                    Spacer()
                }
            }
            .padding(AppSpacing.xSmall)
        }
        .frame(width: spectrumRatio.size.width, height: spectrumRatio.size.height)
        .appShadow(AppShadow.elevated)
    }
}

#Preview {
    HStack(spacing: AppSpacing.medium) {
        CardDistributionSkeleton(spectrumRatio: .horizontal)
        CardDistributionSkeleton(spectrumRatio: .vertical)
    }
    .padding()
    .appScreenBackground()
}
