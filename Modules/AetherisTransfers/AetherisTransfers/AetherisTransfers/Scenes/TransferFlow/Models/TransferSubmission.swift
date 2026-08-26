import AetherisAuthenticationInterface
import Foundation

struct TransferSubmission: Hashable {
    let draft: TransferDraft
    let authorization: IdentityAuthorization
    let idempotencyKey: String
}
