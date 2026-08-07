import AetherisDesignSystem
import SwiftUI

struct VirtualCardUsageSummary: View {
    let availableLimit: Decimal
    let totalLimit: Decimal
    let monthlyExpenses: Decimal

    private var usageProgress: Double {
        guard totalLimit > 0 else { return 0 }

        let usedLimit = max(totalLimit - availableLimit, 0)
        return min(
            max(NSDecimalNumber(decimal: usedLimit / totalLimit).doubleValue, 0),
            1
        )
    }

    private var monthlyUsagePercentage: Int {
        guard totalLimit > 0 else { return 0 }

        let percentage = NSDecimalNumber(decimal: monthlyExpenses / totalLimit * 100).doubleValue
        return Int(percentage.rounded())
    }

    var body: some View {
        HStack(alignment: .top, spacing: AppSpacing.medium) {
            availableLimitView

            Divider()
                .frame(height: 100)

            monthlyExpensesView
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }

    private var availableLimitView: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
            Text(Strings.VirtualCard.availableLimit)
                .font(AppTypography.cellCaption)
                .foregroundStyle(Color.textSecondaryColor)

            Text(availableLimit.currencyFormatted)
                .font(AppTypography.onboardingBody)
                .bold()
                .foregroundStyle(Color.textPrimary)

            ProgressView(value: usageProgress)
                .tint(Color.brandPrimaryColor)

            Text("de \(totalLimit.currencyFormatted)")
                .font(AppTypography.cellCaption)
                .foregroundStyle(Color.textTertiary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var monthlyExpensesView: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
            Text(Strings.VirtualCard.monthlyExpenses)
                .font(AppTypography.cellCaption)
                .foregroundStyle(Color.textSecondaryColor)

            Text(monthlyExpenses.currencyFormatted)
                .font(AppTypography.onboardingBody)
                .bold()
                .foregroundStyle(Color.textPrimary)

            Text("\(monthlyUsagePercentage)% do limite utilizado")
                .font(AppTypography.cellCaption)
                .foregroundStyle(Color.textSecondaryColor)

            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
