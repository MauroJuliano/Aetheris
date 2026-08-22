import AetherisDesignSystem
import Foundation
import SwiftUI

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
