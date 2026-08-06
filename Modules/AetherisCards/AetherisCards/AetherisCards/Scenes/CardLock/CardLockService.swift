import AetherisDesignSystem
import Core
import Foundation

protocol CardLockServicing {
    func fetchCardStatus(cardId: UUID) async throws -> CardLockModel
    func updateCardStatus(cardId: UUID, isBlocked: Bool) async throws -> CardLockModel
}

final class CardLockService: CardLockServicing {
    private let coreService: any HasCoreService
    private var cachedCards: [UUID: CardLockModel] = [:]

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func fetchCardStatus(cardId: UUID) async throws -> CardLockModel {
        if let cachedCard = cachedCards[cardId] {
            return cachedCard
        }

        let card: CardLockModel = try await coreService.execute(
            CardLockEndpoint.status(cardId: cardId)
        )
        cachedCards[cardId] = card

        return card
    }

    func updateCardStatus(cardId: UUID, isBlocked: Bool) async throws -> CardLockModel {
        let currentCard: CardLockModel

        if let cachedCard = cachedCards[cardId] {
            currentCard = cachedCard
        } else {
            currentCard = try await fetchCardStatus(cardId: cardId)
        }

        let updatedCard = currentCard.updating(isBlocked: isBlocked)
        let request = CardLockStatusUpdateRequest(isBlocked: isBlocked)

        let card: CardLockModel = try await coreService.execute(
            CardLockEndpoint.updateStatus(card: updatedCard, request: request)
        )
        cachedCards[cardId] = card

        return card
    }
}

private struct CardLockStatusUpdateRequest: Codable {
    let isBlocked: Bool
}

private enum CardLockEndpoint {
    case status(cardId: UUID)
    case updateStatus(card: CardLockModel, request: CardLockStatusUpdateRequest)
}

extension CardLockEndpoint: Endpoint {
    var path: String {
        switch self {
        case .status(let cardId):
            return "/payments/cards/\(cardId.uuidString)/lock-status"
        case .updateStatus(let card, _):
            return "/payments/cards/\(card.id.uuidString)/lock-status"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .status:
            return .get
        case .updateStatus:
            return .post
        }
    }

    var body: Encodable? {
        switch self {
        case .status:
            return nil
        case .updateStatus(_, let request):
            return request
        }
    }

    var mockResponseData: Data {
        switch self {
        case .status(let cardId):
            return Self.encodeOrEmpty(CardLockModel.mock(cardId: cardId))
        case .updateStatus(let card, _):
            return Self.encodeOrEmpty(card)
        }
    }

    private static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }
}

private extension CardLockModel {
    static func mock(cardId: UUID) -> CardLockModel {
        switch cardId {
        case CardMockIDs.gold:
            return CardLockModel(
                id: cardId,
                holderName: "Marina Souza",
                lastFourDigits: "7373",
                expirationDate: "02/29",
                brand: .mastercard,
                style: .gold,
                isBlocked: false
            )
        case CardMockIDs.infinite:
            return CardLockModel(
                id: cardId,
                holderName: "Marina Souza",
                lastFourDigits: "7676",
                expirationDate: "02/30",
                brand: .mastercard,
                style: .infinite,
                isBlocked: true
            )
        default:
            return CardLockModel(
                id: cardId,
                holderName: "Jorge Henrique",
                lastFourDigits: "4421",
                expirationDate: "09/29",
                brand: .visa,
                style: .standard,
                isBlocked: false
            )
        }
    }
}
