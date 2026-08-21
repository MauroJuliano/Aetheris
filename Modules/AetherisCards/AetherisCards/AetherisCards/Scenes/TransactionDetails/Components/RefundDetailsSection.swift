import AetherisDesignSystem
import Foundation
import SwiftUI

struct RefundDetailsSection: View {
    let details: RefundDetailsModel
    let onOriginalTransactionTap: () -> Void
    let isLoading: Bool

    init(
        details: RefundDetailsModel,
        onOriginalTransactionTap: @escaping () -> Void,
        isLoading: Bool = false
    ) {
        self.details = details
        self.onOriginalTransactionTap = onOriginalTransactionTap
        self.isLoading = isLoading
    }

    var body: some View {
        TransactionDetailsCard(
            title: Strings.TransactionDetails.refundDetails,
            isLoading: isLoading
        ) {
            TransactionDetailRow(
                title: Strings.TransactionDetails.originalTransaction,
                icon: "receipt",
                value: details.originalMerchantName,
                subtitle: details.originalPurchaseDate.shortTransactionDateFormatted,
                showsChevron: true,
                action: onOriginalTransactionTap
            )
            .toSkeleton(enable: isLoading)

            if let reason = details.refundReason {
                TransactionDetailsDivider()

                TransactionDetailRow(
                    title: Strings.TransactionDetails.reason,
                    icon: "text.bubble",
                    value: reason
                )
                .toSkeleton(enable: isLoading)
            }

            if let availabilityDate = details.expectedAvailabilityDate {
                TransactionDetailsDivider()

                TransactionDetailRow(
                    title: Strings.TransactionDetails.expectedAvailability,
                    icon: "calendar",
                    value: availabilityDate.shortTransactionDateFormatted
                )
                .toSkeleton(enable: isLoading)
            }
        }
    }
}
