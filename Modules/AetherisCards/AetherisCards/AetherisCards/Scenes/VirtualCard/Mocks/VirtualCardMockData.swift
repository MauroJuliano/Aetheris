import AetherisDesignSystem
import Foundation

extension VirtualCardDashboard {
    static func mock(physicalCardId: UUID) -> VirtualCardDashboard {
        VirtualCardDashboard(
            virtualCard: VirtualCardModel.mock(physicalCardId: physicalCardId),
            summaries: FinancialSummaryModel.virtualCardMockSummaries(physicalCardId: physicalCardId)
        )
    }
}

extension VirtualCardModel {
    static func mock(
        id: UUID? = nil,
        physicalCardId: UUID,
        cardNumber: String? = nil,
        securityCode: String? = nil,
        isActive: Bool = true
    ) -> VirtualCardModel {
        let profile = CardVirtualMockProfile.profile(for: physicalCardId)

        return VirtualCardModel(
            id: id ?? VirtualCardMockIDs.id(for: physicalCardId),
            physicalCardId: physicalCardId,
            holderName: profile.holderName,
            cardNumber: cardNumber ?? profile.cardNumber,
            expirationDate: profile.expirationDate,
            securityCode: securityCode ?? profile.securityCode,
            brand: profile.brand,
            style: profile.style,
            availableLimit: profile.availableLimit,
            totalLimit: profile.totalLimit,
            monthlyExpenses: profile.monthlyExpenses,
            isActive: isActive
        )
    }

    func updating(isActive: Bool) -> VirtualCardModel {
        VirtualCardModel(
            id: id,
            physicalCardId: physicalCardId,
            holderName: holderName,
            cardNumber: cardNumber,
            expirationDate: expirationDate,
            securityCode: securityCode,
            brand: brand,
            style: style,
            availableLimit: availableLimit,
            totalLimit: totalLimit,
            monthlyExpenses: monthlyExpenses,
            isActive: isActive
        )
    }

    func regeneratingNumber() -> VirtualCardModel {
        let profile = CardVirtualMockProfile.profile(for: physicalCardId)

        return VirtualCardModel(
            id: id,
            physicalCardId: physicalCardId,
            holderName: holderName,
            cardNumber: profile.regeneratedCardNumber,
            expirationDate: expirationDate,
            securityCode: profile.regeneratedSecurityCode,
            brand: brand,
            style: style,
            availableLimit: availableLimit,
            totalLimit: totalLimit,
            monthlyExpenses: monthlyExpenses,
            isActive: true
        )
    }
}

enum VirtualCardMockIDs {
    static func id(for physicalCardId: UUID) -> UUID {
        switch physicalCardId {
        case CardMockIDs.gold:
            return UUID(uuidString: "33333333-3333-3333-3333-333333330001")!
        case CardMockIDs.infinite:
            return UUID(uuidString: "44444444-4444-4444-4444-444444440001")!
        default:
            return UUID(uuidString: "11111111-1111-1111-1111-111111110001")!
        }
    }
}

extension FinancialSummaryModel {
    static func virtualCardMockSummaries(physicalCardId: UUID) -> [FinancialSummaryModel] {
        let transactions: [VirtualCardMockTransaction]

        switch physicalCardId {
        case CardMockIDs.gold:
            transactions = [
                .init(
                    image: "NetflixLogo",
                    title: Strings.FinancialSummary.netflix,
                    description: Strings.FinancialSummary.subscription,
                    value: "-$ 20.00",
                    dayOffset: -1
                ),
                .init(
                    image: "applelogo",
                    title: Strings.FinancialSummary.appleBill,
                    description: Strings.FinancialSummary.subscription,
                    value: "-$ 49.90",
                    dayOffset: -4
                ),
                .init(
                    image: "sophie",
                    title: Strings.FinancialSummary.transferSent,
                    description: Strings.FinancialSummary.transferSentDescription,
                    value: "-$ 180.00",
                    dayOffset: -8
                )
            ]
        case CardMockIDs.infinite:
                transactions = [
                    .init(
                        image: "Amelia",
                        title: Strings.FinancialSummary.transferSent,
                        description: Strings.FinancialSummary.transferSentAmeliaDescription,
                        value: "-$ 70.00",
                        dayOffset: -2
                    ),
                    .init(
                        image: "ifoodlogo",
                        title: Strings.FinancialSummary.ifoodBar,
                    description: Strings.FinancialSummary.restaurant,
                    value: "-$ 92.30",
                    dayOffset: -5
                ),
                .init(
                    image: "Amelia",
                    title: Strings.FinancialSummary.paymentReceived,
                    description: Strings.FinancialSummary.paymentReceivedDescription,
                    value: "$ 125.00",
                    dayOffset: -12
                )
            ]
        default:
            transactions = [
                .init(
                    image: "applelogo",
                    title: Strings.FinancialSummary.appleBill,
                    description: Strings.FinancialSummary.subscription,
                    value: "-$ 29.90",
                    dayOffset: 0
                ),
                .init(
                    image: "NetflixLogo",
                    title: Strings.FinancialSummary.netflix,
                    description: Strings.FinancialSummary.subscription,
                    value: "-$ 55.90",
                    dayOffset: -2
                ),
                .init(
                    image: "ifoodlogo",
                    title: Strings.FinancialSummary.ifoodBar,
                    description: Strings.FinancialSummary.restaurant,
                    value: "-$ 82.40",
                    dayOffset: -6
                )
            ]
        }

        return transactions.map {
            FinancialSummaryModel(
                cardId: physicalCardId,
                image: $0.image,
                title: $0.title,
                description: $0.description,
                value: $0.value,
                tag: $0.value.hasPrefix("-") ? .expense : .income,
                date: Calendar.current.date(byAdding: .day, value: $0.dayOffset, to: Date()) ?? Date()
            )
        }
    }
}

struct VirtualCardMockTransaction {
    let image: String
    let title: String
    let description: String
    let value: String
    let dayOffset: Int
}

struct CardVirtualMockProfile {
    let holderName: String
    let cardNumber: String
    let regeneratedCardNumber: String
    let expirationDate: String
    let securityCode: String
    let regeneratedSecurityCode: String
    let brand: CardBrand
    let style: CreditCardStyle
    let availableLimit: Decimal
    let totalLimit: Decimal
    let monthlyExpenses: Decimal

    static func profile(for physicalCardId: UUID) -> CardVirtualMockProfile {
        switch physicalCardId {
        case CardMockIDs.gold:
            return CardVirtualMockProfile(
                holderName: "Marina Souza",
                cardNumber: "5329123412347373",
                regeneratedCardNumber: "5329123412348831",
                expirationDate: "02/29",
                securityCode: "737",
                regeneratedSecurityCode: "831",
                brand: .mastercard,
                style: .gold,
                availableLimit: 8_200,
                totalLimit: 12_000,
                monthlyExpenses: 1_450
            )
        case CardMockIDs.infinite:
            return CardVirtualMockProfile(
                holderName: "Marina Souza",
                cardNumber: "5329456712347676",
                regeneratedCardNumber: "5329456712349004",
                expirationDate: "02/30",
                securityCode: "676",
                regeneratedSecurityCode: "904",
                brand: .mastercard,
                style: .infinite,
                availableLimit: 18_450,
                totalLimit: 25_000,
                monthlyExpenses: 2_300
            )
        default:
            return CardVirtualMockProfile(
                holderName: "Jorge Henrique",
                cardNumber: "4589123412344421",
                regeneratedCardNumber: "4589123412349918",
                expirationDate: "09/29",
                securityCode: "123",
                regeneratedSecurityCode: "872",
                brand: .visa,
                style: .standard,
                availableLimit: 2_750,
                totalLimit: 5_000,
                monthlyExpenses: 250
            )
        }
    }
}
