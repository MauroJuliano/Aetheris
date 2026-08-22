import AetherisDesignSystem
import Foundation
import SwiftUI

struct TransferDetailsSection: View {
    let details: TransferDetailsModel
    let onRecipientTap: () -> Void
    let isLoading: Bool

    init(
        details: TransferDetailsModel,
        onRecipientTap: @escaping () -> Void,
        isLoading: Bool = false
    ) {
        self.details = details
        self.onRecipientTap = onRecipientTap
        self.isLoading = isLoading
    }

    var body: some View {
        TransactionDetailsCard(
            title: Strings.TransactionDetails.transferDetails,
            isLoading: isLoading
        ) {
            TransactionDetailRow(
                title: Strings.TransactionDetails.to,
                icon: "person",
                value: details.recipientName,
                subtitle: details.recipientContact,
                showsChevron: true,
                action: onRecipientTap
            )
            .toSkeleton(enable: isLoading)

            if let institution = details.destinationInstitution {
                TransactionDetailsDivider()

                TransactionDetailRow(
                    title: Strings.TransactionDetails.institution,
                    icon: "building.columns",
                    value: institution
                )
                .toSkeleton(enable: isLoading)
            }

            TransactionDetailsDivider()

            TransactionDetailRow(
                title: Strings.TransactionDetails.method,
                icon: "arrow.left.arrow.right",
                value: details.method
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
