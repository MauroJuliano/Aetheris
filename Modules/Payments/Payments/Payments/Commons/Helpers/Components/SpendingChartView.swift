import SwiftUI
import AetherisDesignSystem

struct SpendingThisMonthView: View {
    let onViewReportTap: () -> Void

    private let categories: [SpendingCategory] = [
        .init(title: "Shopping", amount: "$ 980.50", percentage: "40%", icon: "bag.fill", color: Color.brandPrimaryColor),
        .init(title: "Bills", amount: "$ 610.00", percentage: "25%", icon: "doc.text.fill", color: .cyan),
        .init(title: "Transport", amount: "$ 420.00", percentage: "17%", icon: "car.fill", color: Color.success),
        .init(title: "Food & Drinks", amount: "$ 417.50", percentage: "18%", icon: "fork.knife", color: .orange)
    ]

    init(onViewReportTap: @escaping () -> Void = {}) {
        self.onViewReportTap = onViewReportTap
    }

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium - AppSpacing.xxxSmall) {
            header

            SpendingLineChart()
                .padding(.top, AppSpacing.xxxSmall)

            categoriesRow
                .padding(.top, AppSpacing.xxSmall)
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }

    private var header: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                Text("Spending this month")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color.textPrimary)

                HStack(spacing: AppSpacing.small) {
                    Text("$ 2,428.00")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(Color.textPrimary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.85)
                        .layoutPriority(1)

                    HStack(spacing: AppSpacing.xxSmall + AppSpacing.xxxSmall) {
                        Image(systemName: "arrow.down")
                        Text("8.3%")
                    }
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(Color.success)
                    .padding(.horizontal, AppSpacing.xSmall + AppSpacing.xxxSmall)
                    .padding(.vertical, AppSpacing.xxSmall + AppSpacing.xxxSmall)
                    .background(
                        Capsule()
                            .fill(Color.success.opacity(0.12))
                    )

                    Text("vs last month")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(Color.textTertiary)
                        .lineLimit(1)
                }
            }

            Spacer()

            Button {
                onViewReportTap()
            } label: {
                Text("View report")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Color.brandPrimaryColor)
                    .padding(.horizontal, AppSpacing.medium + AppSpacing.xxxSmall)
                    .padding(.vertical, AppSpacing.xSmall + AppSpacing.xxxSmall)
                    .background(
                        Capsule()
                            .stroke(Color.brandPrimaryColor.opacity(0.25), lineWidth: 1)
                    )
            }
        }
    }

    private var categoriesRow: some View {
        HStack(spacing: 0) {
            ForEach(categories) { category in
                SpendingCategoryItem(category: category)

                if category.id != categories.last?.id {
                    Divider()
                        .frame(height: 38)
                }
            }
        }
    }
}

struct SpendingCategory: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let amount: String
    let percentage: String
    let icon: String
    let color: Color
}

struct SpendingCategoryItem: View {
    let category: SpendingCategory

    var body: some View {
        HStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(category.color.opacity(0.1))

                Image(systemName: category.icon)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(category.color)
            }
            .frame(width: 34, height: 34)

            VStack(alignment: .leading, spacing: 3) {
                Text(category.title)
                    .font(.system(size: 9, weight: .medium))
                    .foregroundStyle(Color.textTertiary)
                    .lineLimit(1)

                Text(category.amount)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(Color.textPrimary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)

                Text(category.percentage)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundStyle(Color.textTertiary)
                    .lineLimit(1)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    SpendingThisMonthView()
        .padding()
        .background(Color.backgroundColorA)
}
