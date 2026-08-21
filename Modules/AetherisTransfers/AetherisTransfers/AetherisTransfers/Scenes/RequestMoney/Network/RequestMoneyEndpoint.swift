import Core
import Foundation

struct RequestMoneyCreateRequest: Codable {
    let contactId: UUID
    let amount: Decimal
    let reason: String?
}
struct SharedMoneyCreateRequest: Codable {
    let amount: Decimal
    let reason: String?
}

enum RequestMoneyEndpoint {
    case dashboard
    case createRequest(RequestMoneyCreateRequest)
    case createSharedRequest(SharedMoneyCreateRequest)
}

extension RequestMoneyEndpoint: Endpoint {
    var path: String {
        switch self {
        case .dashboard:
            return "/payments/request-money/dashboard"
        case .createRequest:
            return "/payments/money-requests"
        case .createSharedRequest:
            return "/payments/money-requests/share"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .dashboard:
            return .get
        case .createRequest, .createSharedRequest:
            return .post
        }
    }

    var body: Encodable? {
        switch self {
        case .dashboard:
            return nil
        case .createRequest(let request):
            return request
        case .createSharedRequest(let request):
            return request
        }
    }

    var mockResponseData: Data {
        switch self {
        case .dashboard:
            return Self.encodeOrEmpty(RequestMoneyDashboard.mock)
        case .createRequest(let request):
            return Self.encodeOrEmpty(RequestMoneyMock.moneyRequest(for: request))
        case .createSharedRequest(let request):
            return Self.encodeOrEmpty(RequestMoneyMock.sharedRequest(for: request))
        }
    }

    private static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }
}
