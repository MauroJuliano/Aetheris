import AetherisDesignSystem
import Foundation
import SwiftUI

struct IncomingPaymentDetailsSection: View {
    let details: IncomingPaymentDetailsModel
    let onSenderTap: () -> Void
    let onPaymentMethodTap: () -> Void
    let isLoading: Bool

    init(
        details: IncomingPaymentDetailsModel,
        onSenderTap: @escaping () -> Void,
        onPaymentMethodTap: @escaping () -> Void,
        isLoading: Bool = false
    ) {
        self.details = details
        self.onSenderTap = onSenderTap
        self.onPaymentMethodTap = onPaymentMethodTap
        self.isLoading = isLoading
    }

    var body: some View {
        TransactionDetailsCard(
            title: Strings.TransactionDetails.paymentDetails,
            isLoading: isLoading
        ) {
            TransactionDetailRow(
                title: Strings.TransactionDetails.from,
                icon: "building.columns",
                value: details.senderName,
                subtitle: details.senderContact,
                showsChevron: true,
                action: onSenderTap
            )
            .toSkeleton(enable: isLoading)

            TransactionDetailsDivider()

            TransactionDetailRow(
                title: Strings.TransactionDetails.method,
                icon: "arrow.left.arrow.right",
                value: details.method,
                subtitle: details.methodDetails,
                showsChevron: true,
                action: onPaymentMethodTap
            )
            .toSkeleton(enable: isLoading)

            if let reference = details.reference {
                TransactionDetailsDivider()

                TransactionDetailRow(
                    title: Strings.TransactionDetails.reference,
                    icon: "doc.text",
                    value: reference
                )
                .toSkeleton(enable: isLoading)
            }
        }
    }
}
