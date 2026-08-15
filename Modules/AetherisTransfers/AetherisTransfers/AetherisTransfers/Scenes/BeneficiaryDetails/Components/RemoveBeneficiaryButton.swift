import AetherisDesignSystem
import SwiftUI

struct RemoveBeneficiaryButton: View {
    let isLoading: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: AppSpacing.medium) {
                if isLoading {
                    ProgressView()
                        .tint(Color.red)
                        .frame(width: 28)
                } else {
                    Image(systemName: "trash")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(Color.red)
                        .frame(width: 28)
                }

                VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
                    Text(Strings.BeneficiaryDetails.removeBeneficiary)
                        .font(AppTypography.body)
                        .bold()
                        .foregroundStyle(Color.red)

                    Text(Strings.BeneficiaryDetails.removeBeneficiaryDescription)
                        .font(AppTypography.cellCaption)
                        .foregroundStyle(Color.textSecondaryColor)
                        .multilineTextAlignment(.leading)
                }

                Spacer(minLength: 0)
            }
            .padding(AppSpacing.medium)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(isLoading)
        .appCardSurface()
        .accessibilityIdentifier("beneficiaryDetails.removeButton")
    }
}

#Preview {
    VStack(spacing: AppSpacing.medium) {
        RemoveBeneficiaryButton(isLoading: false) {}
        RemoveBeneficiaryButton(isLoading: true) {}
    }
    .padding()
    .appScreenBackground()
}
