import Core
import Foundation

enum CardServiceErrorMessage {
    static func message(
        for error: Error,
        fallback: String
    ) -> String {
        if let coreError = error as? CoreServiceError,
           let message = coreError.serverMessage {
            return message
        }

        return fallback
    }
}
