import SwiftUI

struct BeneficiarySearchBarSkeleton: View {
    var body: some View {
        HStack(spacing: AppSpacing.small) {
            SkeletonBlock(width: 20, height: 20, radius: 10)
            SkeletonBlock(width: 180, height: 18, radius: 9)
            Spacer()
        }
        .padding(.horizontal, AppSpacing.medium)
        .frame(height: 54)
        .background(Color.backgroundColorA)
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.large))
    }
}

#Preview {
    BeneficiarySearchBarSkeleton()
        .padding()
        .appScreenBackground()
}
