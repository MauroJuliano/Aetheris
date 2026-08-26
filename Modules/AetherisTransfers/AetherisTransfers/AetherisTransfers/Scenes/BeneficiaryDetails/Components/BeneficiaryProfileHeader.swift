import AetherisDesignSystem
import SwiftUI

struct BeneficiaryProfileHeader: View {
    let beneficiary: BeneficiaryDetailsModel
    let onTransferTap: () -> Void
    let onRequestMoneyTap: () -> Void
    let onMoreOptionsTap: () -> Void

    var body: some View {
        VStack(spacing: AppSpacing.medium) {
            avatar
            nameView
            beneficiaryBadge
            actions.padding(.top, AppSpacing.small)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, AppSpacing.medium)
        .padding(.vertical, AppSpacing.large)
        .appCardSurface()
    }

    @ViewBuilder
    private var avatar: some View {
        if let imageName = beneficiary.imageName,
           !imageName.isEmpty {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 104, height: 104)
                .clipShape(Circle())
        } else {
            ZStack {
                Circle()
                    .fill(Color.brandPrimaryColor.opacity(0.1))
                    .frame(width: 104, height: 104)

                Text(beneficiary.initials)
                    .font(AppTypography.onboardingBody)
                    .bold()
                    .foregroundStyle(Color.brandPrimaryColor)
            }
        }
    }

    private var nameView: some View {
        HStack(spacing: AppSpacing.xSmall) {
            Text(beneficiary.name)
                .font(AppTypography.sectionTitle)
                .bold()
                .foregroundStyle(Color.textPrimary)
                .multilineTextAlignment(.center)

            if beneficiary.isVerified {
                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 17))
                    .foregroundStyle(Color.brandPrimaryColor)
                    .accessibilityLabel(Strings.BeneficiaryDetails.verified)
            }
        }
    }

    private var beneficiaryBadge: some View {
        Label(beneficiary.kind.title, systemImage: beneficiary.kind.icon)
            .font(AppTypography.cellCaption)
            .bold()
            .foregroundStyle(Color.brandPrimaryColor)
            .padding(.horizontal, AppSpacing.small)
            .padding(.vertical, AppSpacing.xSmall)
            .background(Color.brandPrimaryColor.opacity(0.08))
            .clipShape(Capsule())
    }

    private var actions: some View {
        HStack(spacing: AppSpacing.small) {
            BeneficiaryActionButton(
                title: Strings.BeneficiaryDetails.transfer,
                icon: "arrow.up.right",
                action: onTransferTap
            )
            BeneficiaryActionButton(
                title: Strings.BeneficiaryDetails.request,
                icon: "arrow.down",
                action: onRequestMoneyTap
            )
            BeneficiaryActionButton(
                title: Strings.BeneficiaryDetails.more,
                icon: "ellipsis",
                action: onMoreOptionsTap
            )
        }
    }
}

extension BeneficiaryProfileHeader {
    @ViewBuilder func toSkeleton(enable: Bool) -> some View {
        if enable { BeneficiaryProfileHeaderSkeleton() } else { self }
    }
}

private struct BeneficiaryActionButton: View {
    let title: String
    let icon: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: AppSpacing.xSmall) {
                ZStack {
                    Circle()
                        .fill(Color.brandPrimaryColor.opacity(0.08))
                        .frame(
                            width: AppComponentMetrics.mediumCircleSize,
                            height: AppComponentMetrics.mediumCircleSize
                        )

                    Image(systemName: icon)
                        .font(.system(size: AppCardMetrics.cardButtonIconSize, weight: .regular))
                        .foregroundStyle(Color.brandPrimaryColor)
                }

                Text(title)
                    .font(AppTypography.cellCaption)
                    .bold()
                    .foregroundStyle(Color.textPrimary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.9)
                    .frame(minHeight: 30)
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    BeneficiaryProfileHeader(
        beneficiary: BeneficiaryDetailsMockStore.beneficiary(
            for: BeneficiaryFixtures.defaultSelection.id
        ),
        onTransferTap: {},
        onRequestMoneyTap: {},
        onMoreOptionsTap: {}
    )
    .padding()
    .appScreenBackground()
}
