import AetherisDesignSystem
import SwiftUI

struct IncomingPaymentDetailsSection: View {
    let details: IncomingPaymentDetailsModel
    let onSenderTap: () -> Void
    let onPaymentMethodTap: () -> Void

    var body: some View {
        TransactionDetailsCard(title: Strings.TransactionDetails.paymentDetails) {
            TransactionDetailRow(
                title: Strings.TransactionDetails.from,
                icon: "building.columns",
                value: details.senderName,
                subtitle: details.senderContact,
                showsChevron: true,
                action: onSenderTap
            )
            TransactionDetailsDivider()
            TransactionDetailRow(
                title: Strings.TransactionDetails.method,
                icon: "arrow.left.arrow.right",
                value: details.method,
                subtitle: details.methodDetails,
                showsChevron: true,
                action: onPaymentMethodTap
            )
            if let reference = details.reference {
                TransactionDetailsDivider()
                TransactionDetailRow(
                    title: Strings.TransactionDetails.reference,
                    icon: "doc.text",
                    value: reference
                )
            }
        }
    }
}

struct TransferDetailsSection: View {
    let details: TransferDetailsModel
    let onRecipientTap: () -> Void

    var body: some View {
        TransactionDetailsCard(title: Strings.TransactionDetails.transferDetails) {
            TransactionDetailRow(
                title: Strings.TransactionDetails.to,
                icon: "person",
                value: details.recipientName,
                subtitle: details.recipientContact,
                showsChevron: true,
                action: onRecipientTap
            )
            if let institution = details.destinationInstitution {
                TransactionDetailsDivider()
                TransactionDetailRow(
                    title: Strings.TransactionDetails.institution,
                    icon: "building.columns",
                    value: institution
                )
            }
            TransactionDetailsDivider()
            TransactionDetailRow(
                title: Strings.TransactionDetails.method,
                icon: "arrow.left.arrow.right",
                value: details.method
            )
            if let reference = details.reference {
                TransactionDetailsDivider()
                TransactionDetailRow(
                    title: Strings.TransactionDetails.reference,
                    icon: "doc.text",
                    value: reference
                )
            }
        }
    }
}

struct MerchantDetailsSection: View {
    let details: MerchantDetailsModel
    let onMerchantTap: () -> Void
    let onPaymentMethodTap: () -> Void

    var body: some View {
        TransactionDetailsCard(title: Strings.TransactionDetails.purchaseDetails) {
            TransactionDetailRow(
                title: Strings.TransactionDetails.merchant,
                icon: "storefront",
                value: details.merchantName,
                subtitle: details.descriptor,
                showsChevron: true,
                action: onMerchantTap
            )
            TransactionDetailsDivider()
            TransactionDetailRow(
                title: Strings.TransactionDetails.category,
                icon: "square.grid.2x2",
                value: details.category
            )
            if let location = details.location {
                TransactionDetailsDivider()
                TransactionDetailRow(
                    title: Strings.TransactionDetails.location,
                    icon: "mappin",
                    value: location
                )
            }
            TransactionDetailsDivider()
            TransactionDetailRow(
                title: Strings.TransactionDetails.paymentMethod,
                icon: details.paymentMethod.icon,
                value: details.paymentMethod.displayTitle,
                subtitle: details.paymentMethod.subtitle,
                showsChevron: true,
                action: onPaymentMethodTap
            )
        }
    }
}

struct RefundDetailsSection: View {
    let details: RefundDetailsModel
    let onOriginalTransactionTap: () -> Void

    var body: some View {
        TransactionDetailsCard(title: Strings.TransactionDetails.refundDetails) {
            TransactionDetailRow(
                title: Strings.TransactionDetails.originalTransaction,
                icon: "receipt",
                value: details.originalMerchantName,
                subtitle: details.originalPurchaseDate.shortTransactionDateFormatted,
                showsChevron: true,
                action: onOriginalTransactionTap
            )
            if let reason = details.refundReason {
                TransactionDetailsDivider()
                TransactionDetailRow(
                    title: Strings.TransactionDetails.reason,
                    icon: "text.bubble",
                    value: reason
                )
            }
            if let availabilityDate = details.expectedAvailabilityDate {
                TransactionDetailsDivider()
                TransactionDetailRow(
                    title: Strings.TransactionDetails.expectedAvailability,
                    icon: "calendar",
                    value: availabilityDate.shortTransactionDateFormatted
                )
            }
        }
    }
}

struct InvoicePaymentDetailsSection: View {
    let details: InvoicePaymentDetailsModel
    let onInvoiceTap: () -> Void
    let onPaymentMethodTap: () -> Void

    var body: some View {
        TransactionDetailsCard(title: Strings.TransactionDetails.invoicePaymentDetails) {
            TransactionDetailRow(
                title: Strings.TransactionDetails.invoice,
                icon: "doc.text",
                value: details.billingPeriod,
                subtitle: details.cardName,
                showsChevron: true,
                action: onInvoiceTap
            )
            TransactionDetailsDivider()
            TransactionDetailRow(
                title: Strings.TransactionDetails.paidAmount,
                icon: "dollarsign.circle",
                value: details.paidAmount.absoluteCurrencyFormatted(code: details.currencyCode)
            )
            TransactionDetailsDivider()
            TransactionDetailRow(
                title: Strings.TransactionDetails.paymentMethod,
                icon: details.paymentMethod.icon,
                value: details.paymentMethod.displayTitle,
                subtitle: details.paymentMethod.subtitle,
                showsChevron: true,
                action: onPaymentMethodTap
            )
            TransactionDetailsDivider()
            TransactionDetailRow(
                title: Strings.TransactionDetails.confirmationCode,
                icon: "checkmark.seal",
                value: details.confirmationCode
            )
        }
    }
}

struct SubscriptionDetailsSection: View {
    let details: SubscriptionDetailsModel
    let onMerchantTap: () -> Void
    let onPaymentMethodTap: () -> Void
    let onHistoryTap: () -> Void
    let onBlockMerchantTap: () -> Void

    var body: some View {
        VStack(spacing: AppSpacing.medium) {
            if details.isRecurringPaymentDetected {
                recurringPaymentCard
            }

            subscriptionDetailsCard

            if !details.paymentHistory.isEmpty {
                paymentHistoryCard
            }

            merchantControlCard
        }
    }

    private var recurringPaymentCard: some View {
        HStack(spacing: AppSpacing.medium) {
            iconCircle(systemName: "arrow.triangle.2.circlepath", color: .brandPrimaryColor, size: 50)

            VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
                Text(Strings.TransactionDetails.recurringPayment)
                    .font(AppTypography.body)
                    .bold()
                    .foregroundStyle(Color.textPrimary)

                Text(recurringDescription)
                    .font(AppTypography.cellCaption)
                    .foregroundStyle(Color.textSecondaryColor)
                    .fixedSize(horizontal: false, vertical: true)

                if let nextDate = details.nextExpectedPaymentDate {
                    Text(Strings.TransactionDetails.nextExpectedPayment(nextDate.shortTransactionDateFormatted))
                        .font(AppTypography.cellCaption)
                        .bold()
                        .foregroundStyle(Color.brandPrimaryColor)
                }
            }

            Spacer(minLength: 0)
        }
        .padding(AppSpacing.medium)
        .background(Color.brandPrimaryColor.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.large))
    }

    private var subscriptionDetailsCard: some View {
        TransactionDetailsCard(title: Strings.TransactionDetails.subscriptionDetails) {
            TransactionDetailRow(
                title: Strings.TransactionDetails.merchant,
                icon: "storefront",
                value: details.merchantName,
                subtitle: details.merchantDescriptor,
                showsChevron: true,
                action: onMerchantTap
            )
            TransactionDetailsDivider()
            TransactionDetailRow(
                title: Strings.TransactionDetails.category,
                icon: "square.grid.2x2",
                value: details.category
            )
            TransactionDetailsDivider()
            TransactionDetailRow(
                title: Strings.TransactionDetails.billingFrequency,
                icon: "calendar.badge.clock",
                value: details.billingFrequency.title
            )
            if let nextDate = details.nextExpectedPaymentDate {
                TransactionDetailsDivider()
                TransactionDetailRow(
                    title: Strings.TransactionDetails.nextPayment,
                    icon: "calendar",
                    value: nextDate.shortTransactionDateFormatted
                )
            }
            TransactionDetailsDivider()
            TransactionDetailRow(
                title: Strings.TransactionDetails.expectedAmount,
                icon: "dollarsign.circle",
                value: details.expectedAmount.absoluteCurrencyFormatted(code: details.currencyCode)
            )
            TransactionDetailsDivider()
            TransactionDetailRow(
                title: Strings.TransactionDetails.paymentMethod,
                icon: details.paymentMethod.icon,
                value: details.paymentMethod.displayTitle,
                subtitle: details.paymentMethod.subtitle,
                showsChevron: true,
                action: onPaymentMethodTap
            )
        }
    }

    private var paymentHistoryCard: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(Strings.TransactionDetails.paymentHistory)
                    .font(AppTypography.sectionTitle)
                    .bold()
                    .foregroundStyle(Color.textPrimary)

                Spacer()

                Button(Strings.Common.seeAll, action: onHistoryTap)
                    .font(AppTypography.cellCaption)
                    .bold()
                    .foregroundStyle(Color.brandPrimaryColor)
                    .buttonStyle(.plain)
            }
            .padding(.horizontal, AppSpacing.medium)
            .padding(.top, AppSpacing.medium)
            .padding(.bottom, AppSpacing.small)

            ForEach(Array(details.paymentHistory.prefix(3).enumerated()), id: \.element.id) { index, payment in
                SubscriptionPaymentHistoryRow(payment: payment)

                if index < min(details.paymentHistory.count, 3) - 1 {
                    Divider().padding(.leading, AppSpacing.medium)
                }
            }
        }
        .appCardSurface()
    }

    private var merchantControlCard: some View {
        Button(action: onBlockMerchantTap) {
            HStack(spacing: AppSpacing.medium) {
                iconCircle(
                    systemName: details.merchantIsBlocked ? "checkmark.shield" : "hand.raised",
                    color: details.merchantIsBlocked ? .green : .red,
                    size: 46
                )

                VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
                    Text(details.merchantIsBlocked ? Strings.TransactionDetails.allowFuturePayments : Strings.TransactionDetails.blockFuturePayments)
                        .font(AppTypography.body)
                        .bold()
                        .foregroundStyle(Color.textPrimary)

                    Text(details.merchantIsBlocked ? Strings.TransactionDetails.allowFuturePaymentsDescription : Strings.TransactionDetails.blockFuturePaymentsDescription)
                        .font(AppTypography.cellCaption)
                        .foregroundStyle(Color.textSecondaryColor)
                        .multilineTextAlignment(.leading)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption.bold())
                    .foregroundStyle(Color.textTertiary)
            }
            .padding(AppSpacing.medium)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .appCardSurface()
    }

    private var recurringDescription: String {
        let amount = details.expectedAmount.absoluteCurrencyFormatted(code: details.currencyCode)

        switch details.billingFrequency {
        case .weekly:
            return Strings.TransactionDetails.recurringWeekly(details.merchantName, amount)
        case .monthly:
            return Strings.TransactionDetails.recurringMonthly(details.merchantName, amount)
        case .quarterly:
            return Strings.TransactionDetails.recurringQuarterly(details.merchantName, amount)
        case .yearly:
            return Strings.TransactionDetails.recurringYearly(details.merchantName, amount)
        case .unknown:
            return Strings.TransactionDetails.recurringUnknown
        }
    }
}

struct SubscriptionPaymentHistoryRow: View {
    let payment: SubscriptionPaymentHistoryModel

    var body: some View {
        HStack(spacing: AppSpacing.medium) {
            VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
                Text(payment.date.shortTransactionDateFormatted)
                    .font(AppTypography.body)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.textPrimary)

                Label(payment.status.title, systemImage: payment.status.icon)
                    .font(AppTypography.cellCaption)
                    .foregroundStyle(payment.status.color)
            }

            Spacer()

            Text(payment.amount.absoluteCurrencyFormatted(code: payment.currencyCode))
                .font(AppTypography.body)
                .bold()
                .foregroundStyle(Color.textPrimary)
        }
        .padding(.horizontal, AppSpacing.medium)
        .padding(.vertical, AppSpacing.small)
    }
}

private struct TransactionDetailsCard<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(AppTypography.sectionTitle)
                .bold()
                .foregroundStyle(Color.textPrimary)
                .padding(.top, AppSpacing.medium)
                .padding(.bottom, AppSpacing.small)

            content
        }
        .padding(.horizontal, AppSpacing.medium)
        .appCardSurface()
    }
}

private struct TransactionDetailsDivider: View {
    var body: some View {
        Divider().padding(.leading, 52)
    }
}

private func iconCircle(systemName: String, color: Color, size: CGFloat) -> some View {
    ZStack {
        Circle()
            .fill(color.opacity(0.1))
            .frame(width: size, height: size)

        Image(systemName: systemName)
            .font(.system(size: size * 0.42, weight: .medium))
            .foregroundStyle(color)
    }
}

#Preview {
    ScrollView {
        VStack(spacing: AppSpacing.medium) {
            IncomingPaymentDetailsSection(
                details: IncomingPaymentDetailsModel(
                    senderId: UUID(),
                    senderName: "Melissa Clark",
                    senderContact: "melissa@email.com",
                    method: "ACH",
                    methodDetails: "Checking account",
                    reference: "INV-2048"
                ),
                onSenderTap: {},
                onPaymentMethodTap: {}
            )

            TransferDetailsSection(
                details: TransferDetailsModel(
                    recipientId: UUID(),
                    recipientName: "Ed Sheeran",
                    recipientContact: "+1 (617) 555-0198",
                    destinationInstitution: "Aetheris Bank",
                    method: "Instant transfer",
                    reference: "Dinner"
                ),
                onRecipientTap: {}
            )

            MerchantDetailsSection(
                details: MerchantDetailsModel(
                    merchantId: UUID(),
                    merchantName: "Apple",
                    descriptor: "APPLE.COM/BILL",
                    category: "Digital services",
                    location: "Cupertino, CA",
                    paymentMethod: CardsPreviewData.paymentMethod
                ),
                onMerchantTap: {},
                onPaymentMethodTap: {}
            )

            if let subscriptionDetails = CardsPreviewData.transaction.subscriptionDetails {
                SubscriptionDetailsSection(
                    details: subscriptionDetails,
                    onMerchantTap: {},
                    onPaymentMethodTap: {},
                    onHistoryTap: {},
                    onBlockMerchantTap: {}
                )
            }

            RefundDetailsSection(
                details: RefundDetailsModel(
                    originalTransactionId: UUID(),
                    originalMerchantName: "Swarovski",
                    originalPurchaseDate: Date(),
                    refundReason: "Returned item",
                    expectedAvailabilityDate: Calendar.current.date(
                        byAdding: .day,
                        value: 3,
                        to: Date()
                    )
                ),
                onOriginalTransactionTap: {}
            )

            InvoicePaymentDetailsSection(
                details: InvoicePaymentDetailsModel(
                    invoiceId: UUID(),
                    cardId: CardsPreviewData.cardId,
                    cardName: "Aetheris Visa",
                    billingPeriod: "Aug 2026",
                    paidAmount: 350,
                    currencyCode: "USD",
                    paymentMethod: CardsPreviewData.paymentMethod,
                    confirmationCode: "PAY-2026-08"
                ),
                onInvoiceTap: {},
                onPaymentMethodTap: {}
            )
        }
        .padding()
    }
    .appScreenBackground()
}
