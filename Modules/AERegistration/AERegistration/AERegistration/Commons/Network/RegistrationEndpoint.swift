import Core
import Foundation

enum RegistrationEndpoint {
    case profile(RegistrationProfileRequest)
    case password(RegistrationPasswordRequest)
}

extension RegistrationEndpoint: Endpoint {
    var path: String {
        switch self {
        case .profile:
            return "/registration/profile"
        case .password:
            return "/registration/password"
        }
    }

    var method: HTTPMethod {
        .post
    }

    var headers: [String: String] {
        switch self {
        case .profile:
            return [:]
        case .password:
            return ["Cache-Control": "no-store"]
        }
    }

    var body: Encodable? {
        switch self {
        case let .profile(request):
            return request
        case let .password(request):
            return request
        }
    }

    var mockResponseData: Data {
        switch self {
        case .profile, .password:
            return Self.encodeOrEmpty(true)
        }
    }
}

private extension RegistrationEndpoint {
    static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }
}

struct RegistrationProfileRequest: Codable, Equatable {
    let sin: String
    let mothersName: String
    let userName: String
    let birthdate: String
}

struct RegistrationPasswordRequest: Codable, Equatable {
    // Confirmation is validated locally. A real backend receives this value over
    // HTTPS and is responsible for salted, adaptive password hashing.
    let password: String
}
