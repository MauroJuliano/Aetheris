import SwiftUI

struct AnalyticsCategorySummaryCard: View {
    let item: AnalyticsCategorySummaryItemModel

    var body: some View {
        VStack(alignment: .center, spacing: AppSpacing.xxxSmall) {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(item.iconColor.opacity(0.1))

                Image(systemName: item.icon)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(item.iconColor)
            }
            .frame(width: 34, height: 34)

            Text(item.title)
                .font(.system(size: 9, weight: .medium))
                .foregroundStyle(Color.textTertiary)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .center)

            Text(item.amount)
                .font(.system(size: 12, weight: .bold))
                .foregroundStyle(Color.textPrimary)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
                .frame(maxWidth: .infinity, alignment: .center)

            Text(item.percentage)
                .font(.system(size: 10, weight: .medium))
                .foregroundStyle(Color.textTertiary)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}
