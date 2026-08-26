import AetherisDesignSystem
import SwiftUI

struct VirtualCardUsageSummary: View {
    let availableLimit: Decimal
    let totalLimit: Decimal
    let monthlyExpenses: Decimal
    let usageProgress: Double
    let monthlyUsagePercentage: Int

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

    @ViewBuilder
    func toSkeleton(enable: Bool) -> some View {
        if enable {
            VirtualCardUsageSummarySkeleton()
        } else {
            self
        }
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

            Text(Strings.VirtualCard.totalLimitFormat(totalLimit.currencyFormatted))
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

            Text(Strings.VirtualCard.monthlyUsageFormat(monthlyUsagePercentage))
                .font(AppTypography.cellCaption)
                .foregroundStyle(Color.textSecondaryColor)

            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    VirtualCardUsageSummary(
        availableLimit: CardsPreviewData.virtualCard.availableLimit,
        totalLimit: CardsPreviewData.virtualCard.totalLimit,
        monthlyExpenses: CardsPreviewData.virtualCard.monthlyExpenses,
        usageProgress: CardsPreviewData.virtualCard.usedLimitProgress,
        monthlyUsagePercentage: CardsPreviewData.virtualCard.monthlyUsagePercentage
    )
    .padding()
    .appScreenBackground()
}
