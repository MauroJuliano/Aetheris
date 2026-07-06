import AetherisDesignSystem
import SwiftUI

struct TransferReceiptModel {
    let amount: String
    let recipientName: String
    let recipientEmail: String
    let accountName: String
    let accountLastDigits: String
    let date: String
    let referenceId: String

    static let mock = TransferReceiptModel(
        amount: "$250.00",
        recipientName: "Melissa Johnson",
        recipientEmail: "melissa.j@email.com",
        accountName: "Main Account",
        accountLastDigits: "1234",
        date: "June 22, 2024 at 4:45 PM",
        referenceId: "TRX20240622-445PM"
    )
}

struct TransferSuccessView: View {
    let model: TransferReceiptModel
    var onBack: () -> Void
    var onDone: () -> Void
    var onNewTransfer: () -> Void
    var onCopyReference: (String) -> Void

    init(
        model: TransferReceiptModel = .mock,
        onBack: @escaping () -> Void = {},
        onDone: @escaping () -> Void = {},
        onNewTransfer: @escaping () -> Void = {},
        onCopyReference: @escaping (String) -> Void = { _ in }
    ) {
        self.model = model
        self.onBack = onBack
        self.onDone = onDone
        self.onNewTransfer = onNewTransfer
        self.onCopyReference = onCopyReference
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
    }

    private var header: some View {
        HStack {
            Button(action: onBack) {
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
            Text("Transfer successful!")
                .font(AppTypography.heroTitle)
                .foregroundStyle(Color.textPrimary)

            Text("Your money has been sent successfully.")
                .font(AppTypography.onboardingBody)
                .foregroundStyle(Color.textSecondaryColor)
                .multilineTextAlignment(.center)
        }
    }

    private var receiptCard: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xLarge) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: AppSpacing.xxSmall + AppSpacing.xxxSmall) {
                    Text("Amount")
                        .font(AppTypography.onboardingBody.weight(.medium))
                        .foregroundStyle(Color.textSecondaryColor)

                    Text(model.amount)
                        .font(AppTypography.heroTitle)
                        .foregroundStyle(Color.textPrimary)
                }

                Spacer()

                Label("Completed", systemImage: "checkmark.circle")
                    .font(AppBadgeStyle.font)
                    .appCapsuleBadge(
                        foreground: Color.success,
                        background: Color.success.opacity(0.12)
                    )
            }

            TransferInfoRow(
                imageName: "person.circle.fill",
                title: "To",
                primary: model.recipientName,
                secondary: model.recipientEmail
            )

            Divider()

            TransferInfoRow(
                icon: "building.columns.fill",
                title: "From",
                primary: model.accountName,
                secondary: "•••• \(model.accountLastDigits)"
            )

            Divider()

            TransferInfoRow(
                icon: "calendar",
                title: "Date & Time",
                primary: model.date
            )

            Divider()

            HStack {
                TransferInfoRow(
                    icon: "number",
                    title: "Reference ID",
                    primary: model.referenceId
                )

                Spacer()

                Button {
                    onCopyReference(model.referenceId)
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
                Text("Secure transfer")
                    .font(AppTypography.onboardingBody.weight(.bold))
                    .foregroundStyle(Color.success.opacity(0.9))

                Text("Your transaction is protected and encrypted.")
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
            Button(action: onDone) {
                Text("Done")
                    .font(AppTypography.onboardingBody.weight(.semibold))
                    .foregroundStyle(Color.surface)
                    .frame(maxWidth: .infinity)
                    .frame(height: 58)
                    .background(
                        LinearGradient(
                            colors: [
                                Color.brandPrimaryColor,
                                Color.brandSecondaryColor
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: AppRadius.large - AppSpacing.xxxSmall))
            }

            Button(action: onNewTransfer) {
                Label("Make another transfer", systemImage: "paperplane")
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
    TransferSuccessView()
}
