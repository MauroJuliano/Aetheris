import AetherisDesignSystem
import Foundation
import SwiftUI

struct InvoicePaymentDetailsSection: View {
    let details: InvoicePaymentDetailsModel
    let onInvoiceTap: () -> Void
    let onPaymentMethodTap: () -> Void
    let isLoading: Bool

    init(
        details: InvoicePaymentDetailsModel,
        onInvoiceTap: @escaping () -> Void,
        onPaymentMethodTap: @escaping () -> Void,
        isLoading: Bool = false
    ) {
        self.details = details
        self.onInvoiceTap = onInvoiceTap
        self.onPaymentMethodTap = onPaymentMethodTap
        self.isLoading = isLoading
    }

    var body: some View {
        TransactionDetailsCard(
            title: Strings.TransactionDetails.invoicePaymentDetails,
            isLoading: isLoading
        ) {
            TransactionDetailRow(
                title: Strings.TransactionDetails.invoice,
                icon: "doc.text",
                value: details.billingPeriod,
                subtitle: details.cardName,
                showsChevron: true,
                action: onInvoiceTap
            )
            .toSkeleton(enable: isLoading)

            TransactionDetailsDivider()

            TransactionDetailRow(
                title: Strings.TransactionDetails.paidAmount,
                icon: "dollarsign.circle",
                value: details.paidAmount.absoluteCurrencyFormatted(code: details.currencyCode)
            )
            .toSkeleton(enable: isLoading)

            TransactionDetailsDivider()

            TransactionDetailRow(
                title: Strings.TransactionDetails.paymentMethod,
                icon: details.paymentMethod.icon,
                value: details.paymentMethod.displayTitle,
                subtitle: details.paymentMethod.subtitle,
                showsChevron: true,
                action: onPaymentMethodTap
            )
            .toSkeleton(enable: isLoading)

            TransactionDetailsDivider()

            TransactionDetailRow(
                title: Strings.TransactionDetails.confirmationCode,
                icon: "checkmark.seal",
                value: details.confirmationCode
            )
            .toSkeleton(enable: isLoading)
        }
    }
}
