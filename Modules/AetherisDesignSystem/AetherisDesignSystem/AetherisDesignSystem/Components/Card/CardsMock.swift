public struct CardsMock {
    public static var multipleTypeCards = [Card(content: .creditCard(.init(number: "**** **** **** **21",
                                                                           validDate: "09/25",
                                                                           name: Strings.CreditCard.ownerName,
                                                                           brand: Strings.CreditCard.brandVisa,
                                                                           style: .standard))),
                                           Card(content: .creditCard(.init(number: "**** **** **** **73",
                                                                           validDate: "02/29",
                                                                           name: Strings.CreditCard.ownerNameTwo,
                                                                           brand: Strings.CreditCard.brandMastercard,
                                                                           style: .black)))
    ]
    
    public static var creditCardMocks = [
        Card(
            id: CardMockIDs.standard,
            content: .creditCard(.init(number: "**** **** **** **21",
                                       validDate: "09/25",
                                       name: Strings.CreditCard.ownerName,
                                       brand: Strings.CreditCard.brandVisa,
                                       style: .standard))
        ),
        Card(
            id: CardMockIDs.gold,
            content: .creditCard(.init(number: "**** **** **** **73",
                                       validDate: "02/29",
                                       name: Strings.CreditCard.ownerNameTwo,
                                       brand: Strings.CreditCard.brandMastercard,
                                       style: .gold))
        ),
        Card(
            id: CardMockIDs.infinite,
            content: .creditCard(.init(number: "**** **** **** **76",
                                       validDate: "02/30",
                                       name: Strings.CreditCard.ownerNameTwo,
                                       brand: Strings.CreditCard.brandMastercard,
                                       style: .infinite))
        )
    ]
}
