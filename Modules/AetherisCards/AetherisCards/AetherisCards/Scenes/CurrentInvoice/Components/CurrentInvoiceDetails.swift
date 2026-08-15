import AetherisDesignSystem
import SwiftUI

struct CurrentInvoiceDetails: View {
    let details: CurrentInvoiceDetailsModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(Strings.CurrentInvoice.detailsTitle)
                .font(AppTypography.onboardingBody)
                .bold()
                .foregroundStyle(Color.textPrimary)
                .padding(.horizontal, AppSpacing.medium)
                .padding(.top, AppSpacing.medium)
                .padding(.bottom, AppSpacing.small)

            detailRow(
                title: Strings.CurrentInvoice.purchasesSubtotal,
                subtitle: Strings.CurrentInvoice.purchasesSubtotalDescription,
                value: details.purchasesSubtotal,
                icon: "banknote",
                valueColor: .textPrimary
            )

            Divider()
                .padding(.leading, 72)

            detailRow(
                title: Strings.CurrentInvoice.otherCharges,
                subtitle: Strings.CurrentInvoice.otherChargesDescription,
                value: details.otherCharges,
                icon: "receipt",
                valueColor: .textPrimary
            )

            Divider()
                .padding(.leading, 72)

            detailRow(
                title: Strings.CurrentInvoice.discountsAndCredits,
                subtitle: Strings.CurrentInvoice.discountsAndCreditsDescription,
                value: -details.discountsAndCredits,
                icon: "tag",
                valueColor: .green
            )

            Divider()
                .padding(.leading, 72)

            detailRow(
                title: Strings.CurrentInvoice.invoiceTotal,
                subtitle: nil,
                value: details.total,
                icon: "creditcard",
                valueColor: .textPrimary,
                isHighlighted: true
            )
        }
        .appCardSurface()
    }

    private func detailRow(
        title: String,
        subtitle: String?,
        value: Decimal,
        icon: String,
        valueColor: Color,
        isHighlighted: Bool = false
    ) -> some View {
        HStack(spacing: AppSpacing.medium) {
            ZStack {
                Circle()
                    .fill(Color.brandPrimaryColor.opacity(0.08))
                    .frame(width: 42, height: 42)

                Image(systemName: icon)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(Color.brandPrimaryColor)
            }

            VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
                Text(title)
                    .font(AppTypography.body)
                    .fontWeight(isHighlighted ? .bold : .medium)
                    .foregroundStyle(Color.textPrimary)

                if let subtitle {
                    Text(subtitle)
                        .font(AppTypography.cellCaption)
                        .foregroundStyle(Color.textSecondaryColor)
                }
            }

            Spacer(minLength: AppSpacing.small)

            Text(value.invoiceCurrencyFormatted)
                .font(AppTypography.body)
                .fontWeight(isHighlighted ? .bold : .semibold)
                .foregroundStyle(valueColor)
                .multilineTextAlignment(.trailing)
                .lineLimit(1)
        }
        .padding(.horizontal, AppSpacing.medium)
        .padding(.vertical, AppSpacing.small)
    }
}

#Preview {
    CurrentInvoiceDetails(details: CardsPreviewData.invoice.details)
        .padding()
        .appScreenBackground()
}
