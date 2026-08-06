import Foundation

struct RequestMoneyAmountPresetModel: Identifiable, Codable, Equatable, Hashable {
    let id: String
    let value: Decimal
    let title: String

    init(
        id: String,
        value: Decimal,
        title: String? = nil
    ) {
        self.id = id
        self.value = value
        self.title = title ?? CurrencyInputFormatter.format(value)
    }
}
