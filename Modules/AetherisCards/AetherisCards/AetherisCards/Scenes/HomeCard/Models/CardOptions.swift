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
    static let virtualCardId = "virtual_card"
    static let cardLockId = "card_lock"

    static func send() -> CardOptions {
        CardOptions(
            id: sendId,
            label: Strings.QuickActions.sendTitle,
            icon: "paperplane.fill"
        )
    }

    static func request() -> CardOptions {
        CardOptions(
            id: requestId,
            label: Strings.QuickActions.requestTitle,
            icon: "arrow.down"
        )
    }

    static func virtualCard() -> CardOptions {
        CardOptions(
            id: virtualCardId,
            label: Strings.CardInformation.virtualCardQuickAction,
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
