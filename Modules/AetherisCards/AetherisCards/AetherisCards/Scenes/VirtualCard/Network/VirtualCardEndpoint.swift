import Core
import Foundation

struct VirtualCardStatusUpdateRequest: Codable {
    let isActive: Bool
}
enum VirtualCardEndpoint {
    case dashboard(physicalCardId: UUID)
    case updateStatus(card: VirtualCardModel, request: VirtualCardStatusUpdateRequest)
    case generateNewNumber(card: VirtualCardModel)
}

extension VirtualCardEndpoint: Endpoint {
    var path: String {
        switch self {
        case .dashboard(let physicalCardId):
            return "/payments/cards/\(physicalCardId.uuidString)/virtual-card"
        case .updateStatus(let card, _):
            return "/payments/virtual-cards/\(card.id.uuidString)/status"
        case .generateNewNumber(let card):
            return "/payments/virtual-cards/\(card.id.uuidString)/number"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .dashboard:
            return .get
        case .updateStatus, .generateNewNumber:
            return .post
        }
    }

    var body: Encodable? {
        switch self {
        case .dashboard:
            return nil
        case .updateStatus(_, let request):
            return request
        case .generateNewNumber:
            return nil
        }
    }

    var mockResponseData: Data {
        switch self {
        case .dashboard(let physicalCardId):
            return Self.encodeOrEmpty(VirtualCardDashboard.mock(physicalCardId: physicalCardId))
        case .updateStatus(let card, _):
            return Self.encodeOrEmpty(card)
        case .generateNewNumber(let card):
            return Self.encodeOrEmpty(card.regeneratingNumber())
        }
    }

    private static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }
}
