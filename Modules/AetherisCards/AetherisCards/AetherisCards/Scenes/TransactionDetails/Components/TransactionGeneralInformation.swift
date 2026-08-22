import AetherisDesignSystem
import SwiftUI

struct TransactionGeneralInformation: View {
    let transaction: TransactionDetailsModel
    let isLoading: Bool

    var body: some View {
        VStack(spacing: 0) {
            TransactionDetailRow(
                title: Strings.TransactionDetails.date,
                icon: "calendar",
                value: transaction.date.transactionDateFormatted
            )
            .toSkeleton(enable: isLoading)
            divider
            TransactionDetailRow(
                title: Strings.TransactionDetails.status,
                icon: transaction.status.icon,
                value: transaction.status.title,
                valueColor: transaction.status.color
            )
            .toSkeleton(enable: isLoading)
            divider
            TransactionDetailRow(
                title: Strings.TransactionDetails.transactionId,
                icon: "number",
                value: transaction.transactionCode
            )
            .toSkeleton(enable: isLoading)
            divider
            TransactionDetailRow(
                title: Strings.TransactionDetails.type,
                icon: transaction.categoryIcon,
                value: transaction.categoryTitle
            )
            .toSkeleton(enable: isLoading)
            divider
            TransactionDetailRow(
                title: Strings.TransactionDetails.amount,
                icon: "dollarsign.circle",
                value: transaction.amount.absoluteCurrencyFormatted(code: transaction.currencyCode)
            )
            .toSkeleton(enable: isLoading)

            if let note = transaction.note, !note.isEmpty {
                divider
                TransactionDetailRow(
                    title: Strings.TransactionDetails.note,
                    icon: "message",
                    value: note
                )
                .toSkeleton(enable: isLoading)
            }
        }
        .padding(.horizontal, AppSpacing.medium)
        .appCardSurface()
    }

    private var divider: some View {
        Divider().padding(.leading, 52)
    }
}

#Preview {
    TransactionGeneralInformation(
        transaction: CardsPreviewData.transaction,
        isLoading: false
    )
    .padding()
    .appScreenBackground()
}
