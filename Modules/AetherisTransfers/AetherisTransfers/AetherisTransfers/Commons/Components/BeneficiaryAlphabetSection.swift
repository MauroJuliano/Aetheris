import AetherisDesignSystem
import SwiftUI
import AetherisTransfersInterface

struct BeneficiaryAlphabetSection: View {
    let letter: String
    let beneficiaries: [Beneficiary]
    let isLoading: Bool
    let onSelect: (Beneficiary) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text(letter)
                .font(AppTypography.cellCaption)
                .bold()
                .foregroundStyle(Color.brandPrimaryColor)
                .padding(.horizontal, AppSpacing.small)

            VStack(spacing: AppSpacing.medium) {
                ForEach(beneficiaries) { beneficiary in
                    ContactCardRow(
                        model: beneficiary.cardRowModel,
                        onTap: {
                            onSelect(beneficiary)
                        }
                    )
                    .toSkeleton(enable: isLoading)
                }
            }
        }
    }
}

#Preview {
    BeneficiaryAlphabetSection(
        letter: "A",
        beneficiaries: Array(BeneficiaryFixtures.defaults.prefix(2)),
        isLoading: false,
        onSelect: { _ in }
    )
    .padding()
    .appScreenBackground()
}
