import SwiftUI

public struct AnalyticsCategorySummary: View {
    public let items: [AnalyticsCategorySummaryItemModel]

    public init(items: [AnalyticsCategorySummaryItemModel]) {
        self.items = items
    }

    public var body: some View {
        HStack(spacing: AppSpacing.medium) {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                AnalyticsCategorySummaryCard(item: item)

                if index < items.count - 1 {
                    Divider()
                        .frame(height: 54)
                }
            }
        }
    }

    @ViewBuilder
    public func toSkeleton(enable: Bool) -> some View {
        if enable {
            AnalyticsCategorySummarySkeleton(itemsCount: items.count)
        } else {
            self
        }
    }
}
