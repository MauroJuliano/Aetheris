import AetherisDesignSystem
import SwiftUI

struct TransactionGeneralInformation: View {
    let transaction: TransactionDetailsModel

    var body: some View {
        VStack(spacing: 0) {
            TransactionDetailRow(
                title: Strings.TransactionDetails.date,
                icon: "calendar",
                value: transaction.date.transactionDateFormatted
            )
            divider
            TransactionDetailRow(
                title: Strings.TransactionDetails.status,
                icon: transaction.status.icon,
                value: transaction.status.title,
                valueColor: transaction.status.color
            )
            divider
            TransactionDetailRow(
                title: Strings.TransactionDetails.transactionId,
                icon: "number",
                value: transaction.transactionCode
            )
            divider
            TransactionDetailRow(
                title: Strings.TransactionDetails.type,
                icon: transaction.categoryIcon,
                value: transaction.categoryTitle
            )
            divider
            TransactionDetailRow(
                title: Strings.TransactionDetails.amount,
                icon: "dollarsign.circle",
                value: transaction.amount.absoluteCurrencyFormatted(code: transaction.currencyCode)
            )

            if let note = transaction.note, !note.isEmpty {
                divider
                TransactionDetailRow(
                    title: Strings.TransactionDetails.note,
                    icon: "message",
                    value: note
                )
            }
        }
        .padding(.horizontal, AppSpacing.medium)
        .appCardSurface()
    }

    private var divider: some View {
        Divider().padding(.leading, 52)
    }
}
