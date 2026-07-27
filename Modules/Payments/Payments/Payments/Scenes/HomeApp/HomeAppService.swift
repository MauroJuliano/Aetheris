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
    let kind: String
    let number: String?
    let validDate: String?
    let name: String?
    let brand: String?
    let style: CreditCardStyle?
    let headline: String?
    let title: String?
    let caption: String?
    let icon: String?
    let button: String?
    let color: String?

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
        .info(headline: Strings.HomeApp.rewardsHeadline,
              title: Strings.HomeApp.rewardsTitle,
              caption: Strings.HomeApp.rewardsCaption,
              icon: "gift",
              button: Strings.HomeApp.redeem,
              color: "primaryColor"),
        .creditCard(number: "**** **** **** **73",
                    validDate: "02/29",
                    name: Strings.HomeApp.mockCardOwnerTwo,
                    brand: Strings.HomeApp.mockMastercard,
                    style: .black),
        .info(headline: Strings.HomeApp.specialOfferHeadline,
              title: Strings.HomeApp.specialOfferTitle,
              caption: Strings.HomeApp.specialOfferCaption,
              icon: "shield.fill",
              button: Strings.HomeApp.learnMore,
              color: "accentColorB"),
    ]

    static func creditCard(number: String,
                           validDate: String,
                           name: String,
                           brand: String,
                           style: CreditCardStyle = .standard) -> HomeAppCardPayload {
        .init(kind: "creditCard",
              number: number,
              validDate: validDate,
              name: name,
              brand: brand,
              style: style,
              headline: nil,
              title: nil,
              caption: nil,
              icon: nil,
              button: nil,
              color: nil)
    }

    static func info(headline: String,
                     title: String?,
                     caption: String?,
                     icon: String?,
                     button: String,
                     color: String) -> HomeAppCardPayload {
        .init(kind: "info",
              number: nil,
              validDate: nil,
              name: nil,
              brand: nil,
              style: nil,
              headline: headline,
              title: title,
              caption: caption,
              icon: icon,
              button: button,
              color: color)
    }

    var model: Card? {
        switch kind {
        case "creditCard":
            guard let number, let validDate, let name, let brand else { return nil }
            return Card(content: .creditCard(.init(number: number,
                                                    validDate: validDate,
                                                    name: name,
                                                    brand: brand,
                                                    style: style ?? .standard)))
        case "info":
            guard let headline, let button else { return nil }
            return Card(content: .info(.init(headline: headline,
                                             title: title,
                                             caption: caption,
                                             icon: icon,
                                             button: button,
                                             color: color.map(Self.cardColor) ?? .brandPrimaryColor)))
        default:
            return nil
        }
    }

    private static func cardColor(_ token: String) -> Color {
        switch token {
        case "primaryColor":
            .primaryColor
        case "secondaryColor":
            .secondaryColor
        case "accentColorB":
            .accentColorB
        default:
            .brandPrimaryColor
        }
    }
}
