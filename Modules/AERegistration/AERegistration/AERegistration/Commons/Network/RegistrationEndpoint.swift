import Core
import Foundation

enum RegistrationEndpoint {
    case mothersName(String)
    case userName(String)
    case birthdate(String)
    case sin(String)
    case complete(RegistrationCompletionRequest)
}

extension RegistrationEndpoint: Endpoint {
    var path: String {
        switch self {
        case .mothersName:
            return "https://api.aetheris.app/registration/mothers-name"
        case .userName:
            return "https://api.aetheris.app/registration/user-name"
        case .birthdate:
            return "https://api.aetheris.app/registration/birthdate"
        case .sin:
            return "https://api.aetheris.app/registration/sin"
        case .complete:
            return "https://api.aetheris.app/registration/complete"
        }
    }

    var method: HTTPMethod {
        .post
    }

    var body: Encodable? {
        switch self {
        case let .mothersName(mothersName):
            return MothersNameRequest(mothersName: mothersName)
        case let .userName(userName):
            return UserNameRequest(userName: userName)
        case let .birthdate(birthdate):
            return BirthdateRequest(birthdate: birthdate)
        case let .sin(sin):
            return SINRequest(sin: sin)
        case let .complete(request):
            return request
        }
    }

    var mockResponseData: Data {
        switch self {
        case let .mothersName(mothersName):
            return Self.encodeOrEmpty(RegisterModel(mothersName: mothersName))
        case .userName,
             .birthdate,
             .sin:
            return Self.encodeOrEmpty(true)
        case .complete:
            return Self.encodeOrEmpty(true)
        }
    }
}

private extension RegistrationEndpoint {
    static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }
}

private struct MothersNameRequest: Encodable {
    let mothersName: String
}

private struct UserNameRequest: Encodable {
    let userName: String
}

private struct BirthdateRequest: Encodable {
    let birthdate: String
}

private struct SINRequest: Encodable {
    let sin: String
}

struct RegistrationCompletionRequest: Codable {
    let sin: String
    let mothersName: String
    let userName: String
    let birthdate: String
    let password: String
}
