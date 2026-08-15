import AetherisDesignSystem
import SwiftUI

struct TransferSuccessView: View {
    @StateObject private var viewModel: TransferSuccessViewModel

    init(
        viewModel: TransferSuccessViewModel
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: AppSpacing.xLarge + AppSpacing.xxSmall) {
                header
                successIcon
                titleSection
                receiptCard
                secureTransferCard
                actionButtons
            }
            .padding(.horizontal, AppSpacing.xLarge)
            .padding(.bottom, AppSpacing.xxLarge + AppSpacing.xxSmall)
        }
        .appScreenBackground()
        .accessibilityIdentifier("transfer.successScreen")
    }

    private var header: some View {
        HStack {
            Button(action: viewModel.onBack) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(Color.textPrimary)
                    .frame(width: 56, height: 56)
                    .background(Color.surface)
                    .clipShape(Circle())
            }

            Spacer()
        }
        .padding(.top, AppSpacing.screenHorizontal)
    }

    private var successIcon: some View {
        ZStack {
            Circle()
                .fill(Color.success.opacity(0.12))
                .frame(width: 170, height: 170)

            Circle()
                .fill(Color.success.opacity(0.16))
                .frame(width: 90, height: 90)

            Image(systemName: "checkmark")
                .font(.system(size: 52, weight: .bold))
                .foregroundStyle(Color.brandPrimaryColor)
        }
        .padding(.top, AppSpacing.xSmall + AppSpacing.xxxSmall)
    }

    private var titleSection: some View {
        VStack(spacing: AppSpacing.xSmall) {
            Text(Strings.TransferSuccess.title)
                .font(AppTypography.heroTitle)
                .foregroundStyle(Color.textPrimary)

            Text(Strings.TransferSuccess.subtitle)
                .font(AppTypography.onboardingBody)
                .foregroundStyle(Color.textSecondaryColor)
                .multilineTextAlignment(.center)
        }
    }

    private var receiptCard: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xLarge) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: AppSpacing.xxSmall + AppSpacing.xxxSmall) {
                    Text(Strings.TransferSuccess.amount)
                        .font(AppTypography.onboardingBody.weight(.medium))
                        .foregroundStyle(Color.textSecondaryColor)

                    Text(viewModel.model.amount)
                        .font(AppTypography.heroTitle)
                        .foregroundStyle(Color.textPrimary)
                }

                Spacer()

                Label(Strings.TransferSuccess.completed, systemImage: "checkmark.circle")
                    .font(AppBadgeStyle.font)
                    .appCapsuleBadge(
                        foreground: Color.success,
                        background: Color.success.opacity(0.12)
                    )
            }

            TransferInfoRow(
                imageName: "person.circle.fill",
                title: Strings.TransferSuccess.to,
                primary: viewModel.model.recipientName,
                secondary: viewModel.model.recipientEmail
            )

            Divider()

            TransferInfoRow(
                icon: "building.columns.fill",
                title: Strings.TransferSuccess.from,
                primary: viewModel.model.accountName,
                secondary: "•••• \(viewModel.model.accountLastDigits)"
            )

            Divider()

            TransferInfoRow(
                icon: "calendar",
                title: Strings.TransferSuccess.dateAndTime,
                primary: viewModel.model.date
            )

            Divider()

            HStack {
                TransferInfoRow(
                    icon: "number",
                    title: Strings.TransferSuccess.referenceId,
                    primary: viewModel.model.referenceId
                )

                Spacer()

                Button {
                    viewModel.onCopyReference(viewModel.model.referenceId)
                } label: {
                    Image(systemName: "doc.on.doc")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(Color.brandPrimaryColor)
                }
            }
        }
        .padding(AppSpacing.xLarge)
        .appCardSurface(radius: AppRadius.card, fill: Color.surface, shadow: AppShadow.soft)
    }

    private var secureTransferCard: some View {
        HStack(spacing: AppSpacing.medium + AppSpacing.xxxSmall) {
            ZStack {
                Circle()
                    .fill(Color.success.opacity(0.16))
                    .frame(width: 58, height: 58)

                Image(systemName: "shield.checkered")
                    .font(.system(size: 28))
                    .foregroundStyle(Color.success)
            }

            VStack(alignment: .leading, spacing: AppSpacing.xxSmall + AppSpacing.xxxSmall) {
                Text(Strings.TransferSuccess.secureTransfer)
                    .font(AppTypography.onboardingBody.weight(.bold))
                    .foregroundStyle(Color.success.opacity(0.9))

                Text(Strings.TransferSuccess.secureSubtitle)
                    .font(AppTypography.button)
                    .foregroundStyle(Color.textSecondaryColor)
            }

            Spacer()
        }
        .padding(AppSpacing.large)
        .background(Color.success.opacity(0.08))
        .overlay {
            RoundedRectangle(cornerRadius: AppRadius.large + AppSpacing.xxSmall, style: .continuous)
                .stroke(Color.success.opacity(0.18), lineWidth: 1)
        }
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.large + AppSpacing.xxSmall, style: .continuous))
    }

    private var actionButtons: some View {
        VStack(spacing: AppSpacing.large) {
            GlowButton(title: Strings.TransferSuccess.done) {
                viewModel.onDone()
            }

            Button(action: viewModel.onNewTransfer) {
                Label(Strings.TransferSuccess.anotherTransfer, systemImage: "paperplane")
                    .font(AppTypography.onboardingBody.weight(.semibold))
                    .foregroundStyle(Color.brandPrimaryColor)
            }
        }
    }
}

private struct TransferInfoRow: View {
    let icon: String?
    var imageName: String?
    let title: String
    let primary: String
    let secondary: String?

    init(
        icon: String? = nil,
        imageName: String? = nil,
        title: String,
        primary: String,
        secondary: String? = nil
    ) {
        self.icon = icon
        self.imageName = imageName
        self.title = title
        self.primary = primary
        self.secondary = secondary
    }

    var body: some View {
        HStack(spacing: AppSpacing.medium + AppSpacing.xxxSmall) {
            ZStack {
                Circle()
                    .fill(Color.brandPrimaryColor.opacity(0.13))
                    .frame(width: 58, height: 58)

                if let imageName {
                    Image(systemName: imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                        .foregroundStyle(Color.brandPrimaryColor)
                } else if let icon {
                    Image(systemName: icon)
                        .font(.system(size: 26, weight: .semibold))
                        .foregroundStyle(Color.brandPrimaryColor)
                }
            }

            VStack(alignment: .leading, spacing: AppSpacing.xxSmall) {
                Text(title)
                    .font(AppTypography.cellCaption.weight(.medium))
                    .foregroundStyle(Color.textSecondaryColor)

                Text(primary)
                    .font(AppTypography.onboardingBody.weight(.semibold))
                    .foregroundStyle(Color.textPrimary)

                if let secondary {
                    Text(secondary)
                        .font(AppTypography.cellCaption)
                        .foregroundStyle(Color.textSecondaryColor)
                }
            }
        }
    }
}

#Preview {
    TransferSuccessView(
        viewModel: TransferSuccessViewModel(
            model: TransferReceiptModel(
                amount: "$125.00",
                recipientName: "Sophie Keller",
                recipientEmail: "sophie.keller@aetheris.app",
                accountName: "Aetheris Checking",
                accountLastDigits: "1234",
                date: "Aug 7, 2026 at 4:30 PM",
                referenceId: "TRF-2026-0001"
            ),
            onBack: {},
            onDone: {},
            onNewTransfer: {},
            onCopyReference: { _ in }
        )
    )
}
