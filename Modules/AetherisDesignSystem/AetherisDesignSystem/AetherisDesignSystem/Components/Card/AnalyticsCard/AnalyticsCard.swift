import SwiftUI

public struct AnalyticsCard<ChartContent: View, FooterContent: View>: View {
    private let title: String
    private let totalTitle: String
    private let changeTitle: String
    private let comparisonTitle: String
    private let viewReportTitle: String
    private let onViewReportTap: () -> Void
    private let chartContent: ChartContent
    private let footerContent: FooterContent

    public init(
        title: String,
        totalTitle: String,
        changeTitle: String,
        comparisonTitle: String,
        viewReportTitle: String,
        onViewReportTap: @escaping () -> Void,
        @ViewBuilder chartContent: () -> ChartContent,
        @ViewBuilder footerContent: () -> FooterContent
    ) {
        self.title = title
        self.totalTitle = totalTitle
        self.changeTitle = changeTitle
        self.comparisonTitle = comparisonTitle
        self.viewReportTitle = viewReportTitle
        self.onViewReportTap = onViewReportTap
        self.chartContent = chartContent()
        self.footerContent = footerContent()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium - AppSpacing.xxxSmall) {
            header

            chartContent
                .padding(.top, AppSpacing.xxxSmall)

            footerContent
                .padding(.top, AppSpacing.xxSmall)
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }

    public func toSkeleton(enable: Bool) -> AnyView {
        if enable {
            return AnyView(AnalyticsCardSkeleton())
        } else {
            return AnyView(self)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                    Text(title)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(Color.textPrimary)

                    HStack(spacing: AppSpacing.small) {
                        Text(totalTitle)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(Color.textPrimary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.85)
                            .layoutPriority(1)

                        HStack(spacing: AppSpacing.xxSmall + AppSpacing.xxxSmall) {
                            Image(systemName: "arrow.down")
                            Text(changeTitle)
                        }
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(Color.success)
                        .padding(.horizontal, AppSpacing.xSmall + AppSpacing.xxxSmall)
                        .padding(.vertical, AppSpacing.xxSmall + AppSpacing.xxxSmall)
                        .background(
                            Capsule()
                                .fill(Color.success.opacity(0.12))
                        )
                    }
                }

                Spacer()

                Button {
                    onViewReportTap()
                } label: {
                    Text(viewReportTitle)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(Color.brandPrimaryColor)
                        .padding(.horizontal, AppSpacing.medium + AppSpacing.xxxSmall)
                        .padding(.vertical, AppSpacing.xSmall + AppSpacing.xxxSmall)
                        .background(
                            Capsule()
                                .stroke(Color.brandPrimaryColor.opacity(0.25), lineWidth: 1)
                        )
                }
                .buttonStyle(.plain)
            }

            Text(comparisonTitle)
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(Color.textTertiary)
                .lineLimit(1)
        }
    }
}

#Preview {
    AnalyticsCard(
        title: "Spending this month",
        totalTitle: "$3,428",
        changeTitle: "+18%",
        comparisonTitle: "Compared to last month",
        viewReportTitle: "View report",
        onViewReportTap: {}
    ) {
        RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
            .fill(Color.brandPrimaryColor.opacity(0.12))
            .frame(height: 126)
    } footerContent: {
        HStack(spacing: AppSpacing.medium) {
            ForEach(0..<4, id: \.self) { index in
                VStack(spacing: AppSpacing.xxxSmall) {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color.brandPrimaryColor.opacity(0.12))
                        .frame(width: 34, height: 34)

                    Rectangle()
                        .fill(Color.textTertiary.opacity(0.15))
                        .frame(width: index == 1 ? 58 : 44, height: 10)

                    Rectangle()
                        .fill(Color.textTertiary.opacity(0.15))
                        .frame(width: index == 1 ? 52 : 40, height: 12)

                    Rectangle()
                        .fill(Color.textTertiary.opacity(0.15))
                        .frame(width: index == 1 ? 34 : 28, height: 10)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
    .padding()
    .appScreenBackground()
}
