import AetherisDesignSystem
import Core
import Foundation
import SwiftUI

protocol HomeAppServicing {
    func loadCards() async throws -> [Card]
}

final class HomeAppService: HomeAppServicing {
    private let coreService: any HasCoreService

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func loadCards() async throws -> [Card] {
        let payloads: [HomeAppCardPayload] = try await coreService.execute(HomeAppEndpoint.cards)
        return payloads.compactMap(\.model)
    }
}

private enum HomeAppEndpoint {
    case cards
}

extension HomeAppEndpoint: Endpoint {
    var path: String {
        "https://api.aetheris.app/payments/home/cards"
    }

    var method: HTTPMethod { .get }

    var body: Encodable? { nil }

    var mockResponseData: Data {
        switch self {
        case .cards:
            return Self.encodeOrEmpty(HomeAppCardPayload.mock)
        }
    }

    private static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }
}

private struct HomeAppCardPayload: Codable {
    let number: String?
    let validDate: String?
    let name: String?
    let brand: String?
    let style: CreditCardStyle?

    static let mock: [HomeAppCardPayload] = [
        .creditCard(number: "**** **** **** **21",
                    validDate: "09/25",
                    name: Strings.HomeApp.mockCardOwnerOne,
                    brand: Strings.HomeApp.mockVisa,
                    style: .standard),
        .creditCard(number: "**** **** **** **21",
                    validDate: "09/25",
                    name: Strings.HomeApp.mockCardOwnerOne,
                    brand: Strings.HomeApp.mockVisa,
                    style: .gold),
        .creditCard(number: "**** **** **** **21",
                    validDate: "09/25",
                    name: Strings.HomeApp.mockCardOwnerOne,
                    brand: Strings.HomeApp.mockVisa,
                    style: .aurora),
        .creditCard(number: "**** **** **** **21",
                    validDate: "09/25",
                    name: Strings.HomeApp.mockCardOwnerOne,
                    brand: Strings.HomeApp.mockVisa,
                    style: .infinite),
        .creditCard(number: "**** **** **** **21",
                    validDate: "09/25",
                    name: Strings.HomeApp.mockCardOwnerOne,
                    brand: Strings.HomeApp.mockVisa,
                    style: .platinum),
        .creditCard(number: "**** **** **** **73",
                    validDate: "02/29",
                    name: Strings.HomeApp.mockCardOwnerTwo,
                    brand: Strings.HomeApp.mockMastercard,
                    style: .black),
    ]

    static func creditCard(number: String,
                           validDate: String,
                           name: String,
                           brand: String,
                           style: CreditCardStyle = .standard) -> HomeAppCardPayload {
        .init(number: number,
              validDate: validDate,
              name: name,
              brand: brand,
              style: style)
    }

    var model: Card? {
        guard let number, let validDate, let name, let brand else { return nil }
        return Card(content: .creditCard(.init(number: number,
                                                validDate: validDate,
                                                name: name,
                                                brand: brand,
                                                style: style ?? .standard)))
    }
}
