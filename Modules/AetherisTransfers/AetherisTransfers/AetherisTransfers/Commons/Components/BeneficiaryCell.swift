import SwiftUI
import AetherisTransfersInterface
import AetherisDesignSystem

public struct BeneficiaryCell: View {
    let model: Beneficiary

    var onChange: ((Beneficiary) -> Void)? = nil

    public init(
        model: Beneficiary,
        onChange: ((Beneficiary) -> Void)? = nil
    ) {
        self.model = model
        self.onChange = onChange
    }

    public var body: some View {
        Button {
            onChange?(model)
        } label: {
            HStack(spacing: AppSpacing.medium) {
                beneficiaryImage

                beneficiaryInformation

                Spacer(minLength: AppSpacing.small)

                navigationButton
            }
            .padding(.horizontal, AppSpacing.medium)
            .padding(.vertical, AppSpacing.medium)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .appCardSurface()
        .accessibilityIdentifier("beneficiary.cell")
    }
}

#Preview {
    VStack(spacing: AppSpacing.medium) {
        BeneficiaryCell(
            model: BeneficiaryFixtures.defaults[0]
        )
    }
    .padding()
    .appScreenBackground()
}

private extension BeneficiaryCell {
    var beneficiaryImage: some View {
        Image(model.image)
            .resizable()
            .scaledToFill()
            .frame(width: 60, height: 60)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(
                        Color.brandPrimaryColor.opacity(0.15),
                        lineWidth: 2
                    )
            }
    }

    var beneficiaryInformation: some View {
        VStack(
            alignment: .leading,
            spacing: AppSpacing.xxxSmall
        ) {
            Text(model.name)
                .font(AppTypography.callout)
                .foregroundStyle(Color.textPrimary)
                .bold()
                .lineLimit(1)

            Text(model.pixKey)
                .font(AppTypography.cellCaption)
                .foregroundStyle(Color.textSecondaryColor)
                .lineLimit(1)
                .minimumScaleFactor(0.85)
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
    }

    var navigationButton: some View {
        Image(systemName: "chevron.forward")
            .font(.system(size: 18, weight: .semibold))
            .foregroundStyle(Color.brandPrimaryColor)
            .frame(width: 46, height: 46)
            .background {
                RoundedRectangle(cornerRadius: AppRadius.large)
                    .fill(Color.backgroundColorA)
            }
    }
}
