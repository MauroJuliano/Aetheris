import Foundation

struct IncomingPaymentDetailsModel: Codable, Equatable {
    let senderId: UUID
    let senderName: String
    let senderContact: String?
    let method: String
    let methodDetails: String?
    let reference: String?
}
