import Foundation
import AetherisDesignSystem

public struct SpendingAnalyticsData {
    let categories: [SpendingCategory]

    public static let fixture = SpendingAnalyticsData(
        categories: [
            .init(
                title: Strings.SpendingChart.shopping,
                amount: "$ 980.50",
                percentage: "40%",
                icon: "bag.fill",
                color: .brandPrimaryColor
            ),
            .init(
                title: Strings.SpendingChart.bills,
                amount: "$ 610.00",
                percentage: "25%",
                icon: "doc.text.fill",
                color: .cyan
            ),
            .init(
                title: Strings.SpendingChart.transport,
                amount: "$ 420.00",
                percentage: "17%",
                icon: "car.fill",
                color: .success
            ),
            .init(
                title: Strings.SpendingChart.foodAndDrinks,
                amount: "$ 417.50",
                percentage: "18%",
                icon: "fork.knife",
                color: .orange
            )
        ]
    )
}
