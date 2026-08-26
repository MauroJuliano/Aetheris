import Foundation

struct PaymentMethodSummaryModel: Identifiable, Codable, Equatable {
    let id: UUID
    let title: String
    let subtitle: String?
    let lastFourDigits: String?
    let icon: String

    var displayTitle: String {
        guard let lastFourDigits else { return title }
        return "\(title) **** \(lastFourDigits)"
    }
}
