import SwiftUI

public struct AnalyticsCategorySummaryItemModel: Identifiable, Hashable {
    public let id: String
    public let title: String
    public let amount: String
    public let percentage: String
    public let icon: String
    public let iconColor: Color

    public init(
        id: String = UUID().uuidString,
        title: String,
        amount: String,
        percentage: String,
        icon: String,
        iconColor: Color = .brandPrimaryColor
    ) {
        self.id = id
        self.title = title
        self.amount = amount
        self.percentage = percentage
        self.icon = icon
        self.iconColor = iconColor
    }
}
