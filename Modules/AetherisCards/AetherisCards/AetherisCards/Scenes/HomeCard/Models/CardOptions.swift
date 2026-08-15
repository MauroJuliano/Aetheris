struct CardOptions: Identifiable, Codable, Hashable {
    let id: String
    let label: String
    let icon: String

    init(id: String? = nil, label: String, icon: String) {
        self.id = id ?? label
        self.label = label
        self.icon = icon
    }
}

extension CardOptions {
    static let sendId = "send"
    static let requestId = "request"
    static let payId = "pay"
    static let topUpId = "top_up"
    static let virtualCardId = "virtual_card"
    static let cardLockId = "card_lock"

    static let replacedQuickActionIds: Set<String> = [
        payId,
        topUpId,
        virtualCardId,
        cardLockId
    ]

    static func virtualCard() -> CardOptions {
        CardOptions(
            id: virtualCardId,
            label: "Virtual\ncard",
            icon: "creditcard"
        )
    }

    static func cardLock(isBlocked: Bool) -> CardOptions {
        CardOptions(
            id: cardLockId,
            label: isBlocked ? Strings.CardInformation.unlock : Strings.CardInformation.lock,
            icon: isBlocked ? "lock.open" : "lock"
        )
    }
}
