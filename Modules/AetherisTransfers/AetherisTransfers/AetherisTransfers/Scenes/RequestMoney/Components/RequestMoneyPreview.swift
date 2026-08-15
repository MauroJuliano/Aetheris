import AetherisDesignSystem
import SwiftUI

struct RequestMoneyPreview: View {
    let contact: RequestContactModel?
    let requesterName: String
    let amount: Decimal
    let reason: String?
    let mode: RequestMoneyMode

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium) {
            Text(Strings.RequestMoney.previewTitle)
                .font(AppTypography.body)
                .bold()
                .foregroundStyle(Color.textPrimary)

            HStack(spacing: AppSpacing.medium) {
                requesterColumn

                Spacer()

                Image(systemName: "arrow.right")
                    .font(.system(size: 22, weight: .regular))
                    .foregroundStyle(Color.textSecondaryColor)

                Spacer()

                recipient
            }

            if let reason,
               !reason.isEmpty {
                Divider()

                HStack(alignment: .top, spacing: AppSpacing.xSmall) {
                    Image(systemName: "message")
                        .foregroundStyle(Color.brandPrimaryColor)

                    Text(reason)
                        .font(AppTypography.cellCaption)
                        .foregroundStyle(Color.textSecondaryColor)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            Divider()

            Label(previewInformation, systemImage: "info.circle")
                .font(AppTypography.cellCaption)
                .foregroundStyle(Color.textSecondaryColor)
        }
        .padding(AppSpacing.medium)
        .background(
            LinearGradient(
                colors: [
                    Color.brandPrimaryColor.opacity(0.05),
                    Color.brandTertiaryColor.opacity(0.05)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.large))
    }

    private var requesterColumn: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
            Text(Strings.RequestMoney.youRequest)
                .font(AppTypography.cellCaption)
                .foregroundStyle(Color.textSecondaryColor)

            Text(amount.requestCurrencyFormatted)
                .font(AppTypography.headline)
                .bold()
                .foregroundStyle(Color.textPrimary)
                .lineLimit(1)
                .minimumScaleFactor(0.75)

            if !requesterName.isEmpty {
                Text(requesterName)
                    .font(AppTypography.cellCaption)
                    .foregroundStyle(Color.textSecondaryColor)
                    .lineLimit(1)
            }
        }
    }

    @ViewBuilder
    private var recipient: some View {
        if let contact {
            contactRecipient(contact)
        } else {
            sharedRecipient
        }
    }

    private func contactRecipient(_ contact: RequestContactModel) -> some View {
        HStack(spacing: AppSpacing.small) {
            avatar(for: contact)

            VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
                Text(Strings.RequestMoney.to)
                    .font(AppTypography.cellCaption)
                    .foregroundStyle(Color.textSecondaryColor)

                Text(contact.name)
                    .font(AppTypography.body)
                    .bold()
                    .foregroundStyle(Color.textPrimary)
                    .lineLimit(1)

                Text(contact.contactInformation)
                    .font(AppTypography.cellCaption)
                    .foregroundStyle(Color.textSecondaryColor)
                    .lineLimit(1)
            }
        }
    }

    private var sharedRecipient: some View {
        HStack(spacing: AppSpacing.small) {
            ZStack {
                Circle()
                    .fill(Color.brandPrimaryColor.opacity(0.12))
                    .frame(width: 42, height: 42)

                Image(systemName: "link")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(Color.brandPrimaryColor)
            }

            VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
                Text(Strings.RequestMoney.to)
                    .font(AppTypography.cellCaption)
                    .foregroundStyle(Color.textSecondaryColor)

                Text(Strings.RequestMoney.shareMode)
                    .font(AppTypography.body)
                    .bold()
                    .foregroundStyle(Color.textPrimary)
                    .lineLimit(1)
            }
        }
    }

    @ViewBuilder
    private func avatar(for contact: RequestContactModel) -> some View {
        if let imageName = contact.imageName {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 42, height: 42)
                .clipShape(Circle())
        } else {
            ZStack {
                Circle()
                    .fill(Color.brandPrimaryColor.opacity(0.12))
                    .frame(width: 42, height: 42)

                Text(contact.initials)
                    .font(AppTypography.cellCaption)
                    .bold()
                    .foregroundStyle(Color.brandPrimaryColor)
            }
        }
    }

    private var previewInformation: String {
        switch mode {
        case .contact:
            return Strings.RequestMoney.previewInformation
        case .shareLink:
            return Strings.RequestMoney.shareDescription
        }
    }
}

#Preview("Contact") {
    RequestMoneyPreview(
        contact: .previewSophie,
        requesterName: "Blake Brown",
        amount: 125,
        reason: "Dinner split",
        mode: .contact
    )
    .padding()
    .appScreenBackground()
}

#Preview("Shared link") {
    RequestMoneyPreview(
        contact: nil,
        requesterName: "Blake Brown",
        amount: 80,
        reason: "Event tickets",
        mode: .shareLink
    )
    .padding()
    .appScreenBackground()
}
