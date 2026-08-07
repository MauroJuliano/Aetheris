import AetherisDesignSystem
import SwiftUI

struct CurrentInvoiceOverview: View {
    let invoice: CurrentInvoiceModel
    let onAvailableLimitTap: () -> Void
    let onBestPurchaseDateTap: () -> Void

    var body: some View {
        ViewThatFits(in: .horizontal) {
            desktopOverview
            compactOverview
        }
        .appCardSurface()
    }

    private var desktopOverview: some View {
        HStack(alignment: .top, spacing: AppSpacing.medium) {
            amountColumn

            Divider()
                .frame(height: 170)

            dateColumn

            Divider()
                .frame(height: 170)

            limitColumn
        }
        .padding(AppSpacing.medium)
    }

    private var compactOverview: some View {
        VStack(spacing: AppSpacing.medium) {
            HStack(alignment: .top, spacing: AppSpacing.medium) {
                amountColumn

                Divider()
                    .frame(height: 154)

                dateColumn
            }

            Divider()

            limitColumn
        }
        .padding(AppSpacing.medium)
    }

    private var amountColumn: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
            Text(Strings.CurrentInvoice.totalAmount)
                .font(AppTypography.cellCaption)
                .foregroundStyle(Color.textSecondaryColor)

            Text(invoice.amount.currencyFormatted)
                .font(AppTypography.onboardingBody)
                .bold()
                .foregroundStyle(Color.textPrimary)
                .minimumScaleFactor(0.75)
                .lineLimit(1)

            Text(invoice.status.title)
                .font(AppTypography.cellCaption)
                .bold()
                .foregroundStyle(invoice.status.color)

            Spacer(minLength: AppSpacing.medium)

            Button(action: onAvailableLimitTap) {
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
                        Text(Strings.CurrentInvoice.availableLimit)
                            .font(AppTypography.cellCaption)
                            .foregroundStyle(Color.textSecondaryColor)

                        Text(invoice.availableLimit.currencyFormatted)
                            .font(AppTypography.body)
                            .bold()
                            .foregroundStyle(Color.textPrimary)
                            .minimumScaleFactor(0.75)
                            .lineLimit(1)
                    }

                    Spacer(minLength: AppSpacing.xSmall)

                    Image(systemName: "chevron.right")
                        .font(.caption.bold())
                        .foregroundStyle(Color.textTertiary)
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var dateColumn: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
            HStack(spacing: AppSpacing.small) {
                overviewIcon(systemName: "calendar")

                VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
                    Text(Strings.CurrentInvoice.dueDate)
                        .font(AppTypography.cellCaption)
                        .foregroundStyle(Color.textSecondaryColor)

                    Text(invoice.dueDate.invoiceDateFormatted)
                        .font(AppTypography.body)
                        .bold()
                        .foregroundStyle(Color.textPrimary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                }
            }

            Text(dueDateDescription)
                .font(AppTypography.cellCaption)
                .foregroundStyle(dueDateColor)

            Spacer(minLength: AppSpacing.medium)

            Button(action: onBestPurchaseDateTap) {
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
                        Text(Strings.CurrentInvoice.bestPurchaseDate)
                            .font(AppTypography.cellCaption)
                            .foregroundStyle(Color.textSecondaryColor)

                        Text(invoice.bestPurchaseDate.invoiceDateFormatted)
                            .font(AppTypography.body)
                            .bold()
                            .foregroundStyle(Color.textPrimary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                    }

                    Spacer(minLength: AppSpacing.xSmall)

                    Image(systemName: "chevron.right")
                        .font(.caption.bold())
                        .foregroundStyle(Color.textTertiary)
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var limitColumn: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
            Text(Strings.CurrentInvoice.totalLimit)
                .font(AppTypography.cellCaption)
                .foregroundStyle(Color.textSecondaryColor)

            Text(invoice.totalLimit.currencyFormatted)
                .font(AppTypography.body)
                .bold()
                .foregroundStyle(Color.textPrimary)
                .lineLimit(1)
                .minimumScaleFactor(0.7)

            Spacer(minLength: AppSpacing.medium)

            Text(Strings.CurrentInvoice.usedLimit)
                .font(AppTypography.cellCaption)
                .foregroundStyle(Color.textSecondaryColor)

            Text(invoice.usedLimit.currencyFormatted)
                .font(AppTypography.body)
                .bold()
                .foregroundStyle(Color.textPrimary)
                .lineLimit(1)
                .minimumScaleFactor(0.7)

            Text(Strings.CurrentInvoice.usedLimitPercentage(invoice.usedLimitPercentage))
                .font(AppTypography.cellCaption)
                .foregroundStyle(Color.textSecondaryColor)

            ProgressView(value: invoice.usedLimitProgress)
                .tint(Color.brandPrimaryColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var dueDateDescription: String {
        switch invoice.status {
        case .overdue:
            return Strings.CurrentInvoice.overduePayment
        case .paid:
            return Strings.CurrentInvoice.paidInvoice
        case .open, .closed:
            let days = invoice.daysUntilDueDate

            if days == 0 {
                return Strings.CurrentInvoice.dueToday
            }

            if days == 1 {
                return Strings.CurrentInvoice.oneDayUntilDue
            }

            return Strings.CurrentInvoice.daysUntilDue(days)
        }
    }

    private var dueDateColor: Color {
        invoice.status == .overdue ? .red : .brandPrimaryColor
    }

    private func overviewIcon(systemName: String) -> some View {
        ZStack {
            Circle()
                .fill(Color.brandPrimaryColor.opacity(0.08))
                .frame(width: 42, height: 42)

            Image(systemName: systemName)
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(Color.brandPrimaryColor)
        }
    }
}
