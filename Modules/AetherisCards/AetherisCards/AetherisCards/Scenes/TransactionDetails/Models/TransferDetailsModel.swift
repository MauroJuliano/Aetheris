import Foundation

struct TransferDetailsModel: Codable, Equatable {
    let recipientId: UUID
    let recipientName: String
    let recipientContact: String?
    let destinationInstitution: String?
    let method: String
    let reference: String?
}
