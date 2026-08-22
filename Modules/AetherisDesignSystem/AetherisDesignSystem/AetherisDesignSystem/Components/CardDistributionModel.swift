public struct CardDistributionModel {
    var title: String
    var subTitle: String
    var icon: String

    public init(title: String, subTitle: String, icon: String) {
        self.title = title
        self.subTitle = subTitle
        self.icon = icon
    }

    public static let sampleCreditCard: CardDistributionModel = .init(title: Strings.CardDistribution.creditCardTitle, subTitle: Strings.CardDistribution.creditCardSubtitle, icon: "creditcard")
    public static let sampleLoans: CardDistributionModel = .init(title: Strings.CardDistribution.loanTitle, subTitle: Strings.CardDistribution.loanSubtitle, icon: "chart.line.uptrend.xyaxis")
    public static let sampleInvestments: CardDistributionModel = .init(title: Strings.CardDistribution.investmentsTitle, subTitle: Strings.CardDistribution.investmentsSubtitle, icon: "shield.fill")
}
