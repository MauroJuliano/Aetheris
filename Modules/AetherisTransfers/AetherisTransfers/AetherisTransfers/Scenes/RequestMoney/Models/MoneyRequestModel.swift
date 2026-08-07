import Foundation

struct MoneyRequestModel: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    let contact: RequestContactModel?
    let amount: Decimal
    let reason: String?
    let paymentLink: URL?
    let createdAt: Date
    let status: MoneyRequestStatus
}

enum MoneyRequestStatus: String, Codable, Equatable, Hashable {
    case pending
    case paid
    case cancelled
    case expired
}
