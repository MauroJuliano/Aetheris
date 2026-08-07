import AetherisDesignSystem
import SwiftUI

struct CurrentInvoiceSpendingSummary: View {
    let summary: InvoiceSpendingSummaryModel
    let onChartsTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium) {
            header

            HStack(spacing: AppSpacing.large) {
                InvoiceDonutChart(installmentProgress: summary.installmentProgress)
                    .frame(width: 112, height: 112)

                VStack(alignment: .leading, spacing: AppSpacing.small) {
                    Text(Strings.CurrentInvoice.totalSpent)
                        .font(AppTypography.cellCaption)
                        .foregroundStyle(Color.textSecondaryColor)

                    Text(summary.totalSpent.currencyFormatted)
                        .font(AppTypography.onboardingBody)
                        .bold()
                        .foregroundStyle(Color.textPrimary)

                    legendRow(
                        title: Strings.CurrentInvoice.installment,
                        value: summary.installmentPurchases,
                        isPrimary: true
                    )

                    legendRow(
                        title: Strings.CurrentInvoice.oneTime,
                        value: summary.oneTimePurchases,
                        isPrimary: false
                    )
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }

    private var header: some View {
        HStack {
            Text(Strings.CurrentInvoice.spendingSummaryTitle)
                .font(AppTypography.onboardingBody)
                .bold()
                .foregroundStyle(Color.textPrimary)

            Spacer()

            Button(action: onChartsTap) {
                HStack(spacing: AppSpacing.xSmall) {
                    Image(systemName: "chart.bar")
                    Text(Strings.CurrentInvoice.seeCharts)
                    Image(systemName: "chevron.right")
                        .font(.caption.bold())
                }
                .font(AppTypography.cellCaption)
                .bold()
                .foregroundStyle(Color.brandPrimaryColor)
                .padding(.horizontal, AppSpacing.small)
                .padding(.vertical, AppSpacing.xSmall)
                .background(Color.brandPrimaryColor.opacity(0.08))
                .clipShape(RoundedRectangle(cornerRadius: AppRadius.medium))
            }
            .buttonStyle(.plain)
        }
    }

    private func legendRow(title: String, value: Decimal, isPrimary: Bool) -> some View {
        HStack(spacing: AppSpacing.xSmall) {
            Circle()
                .fill(isPrimary ? Color.brandPrimaryColor : Color.brandPrimaryColor.opacity(0.3))
                .frame(width: 8, height: 8)

            Text(title)
                .font(AppTypography.cellCaption)
                .foregroundStyle(Color.textSecondaryColor)

            Spacer()

            Text(value.currencyFormatted)
                .font(AppTypography.cellCaption)
                .foregroundStyle(Color.textSecondaryColor)
        }
    }
}

#Preview {
    CurrentInvoiceSpendingSummary(
        summary: CardsPreviewData.invoice.spendingSummary,
        onChartsTap: {}
    )
    .padding()
    .appScreenBackground()
}
