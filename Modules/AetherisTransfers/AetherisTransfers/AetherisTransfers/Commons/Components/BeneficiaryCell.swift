import SwiftUI
import AetherisTransfersInterface
import AetherisDesignSystem

public struct BeneficiaryCell: View {
    @State var model: Beneficiary
    let isRecent: Bool

    var onChange: ((Beneficiary) -> Void)? = nil

    public init(
        model: Beneficiary,
        isRecent: Bool = false,
        onChange: ((Beneficiary) -> Void)? = nil
    ) {
        self.model = model
        self.isRecent = isRecent
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
            .padding(.vertical, AppSpacing.small)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .appCardSurface()
    }
}

private extension BeneficiaryCell {
    var beneficiaryImage: some View {
        Image(model.image)
            .resizable()
            .scaledToFill()
            .frame(width: 58, height: 58)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(
                        Color.brandPrimaryColor.opacity(0.15),
                        lineWidth: 3
                    )
            }
    }

    var beneficiaryInformation: some View {
        VStack(
            alignment: .leading,
            spacing: AppSpacing.xSmall
        ) {
            Text(model.name)
                .font(AppTypography.callout)
                .foregroundStyle(Color.textPrimary)
                .bold()
                .lineLimit(1)

            beneficiaryStatus
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
    }

    var beneficiaryStatus: some View {
        HStack(spacing: AppSpacing.xxxSmall) {
            Circle()
                .fill(statusColor)
                .frame(width: 6, height: 6)

            Text(statusTitle)
                .font(AppTypography.cellCaption)
                .foregroundStyle(Color.textSecondaryColor)
        }
        .padding(.horizontal, AppSpacing.small)
        .padding(.vertical, AppSpacing.xxxSmall)
        .background(Color.backgroundColorA)
        .clipShape(Capsule())
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

    var statusTitle: String {
        isRecent
            ? Strings.BeneficiaryList.recentBeneficiary
            : Strings.BeneficiaryList.savedContact
    }

    var statusColor: Color {
        isRecent
            ? .brandPrimaryColor
            : .textTertiary
    }
}
