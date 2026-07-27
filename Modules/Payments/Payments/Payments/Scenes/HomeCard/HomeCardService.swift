import AetherisDesignSystem
import Core
import Foundation
import SwiftUI

protocol HomeCardServicing {
    func loadDashboard() async throws -> HomeCardDashboard
    func loadQuickActions() async throws -> [CardOptions]
}

struct HomeCardDashboard {
    let cards: [Card]
    let summaries: [FinancialSummaryModel]
}

final class HomeCardService: HomeCardServicing {
    private let coreService: any HasCoreService

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func loadDashboard() async throws -> HomeCardDashboard {
        let response: HomeCardResponse = try await coreService.execute(HomeCardEndpoint.dashboard)
        return response.dashboard
    }

    func loadQuickActions() async throws -> [CardOptions] {
        let payloads: [HomeCardQuickActionPayload] = try await coreService.execute(HomeCardEndpoint.quickActions)
        return payloads.compactMap(\.model)
    }
}

private enum HomeCardEndpoint {
    case dashboard
    case quickActions
}

extension HomeCardEndpoint: Endpoint {
    var path: String {
        "https://api.aetheris.app/payments/home-card/dashboard"
    }

    var method: HTTPMethod { .get }

    var body: Encodable? { nil }

    var mockResponseData: Data {
        switch self {
        case .dashboard:
            return Self.encodeOrEmpty(HomeCardResponse.mock)
        case .quickActions:
            return Self.encodeOrEmpty(HomeCardQuickActionPayload.mock)
        }
    }

    private static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }
}

private struct HomeCardResponse: Codable {
    let cards: [HomeCardCardPayload]
    let summaries: [HomeCardSummaryPayload]

    var dashboard: HomeCardDashboard {
        HomeCardDashboard(
            cards: cards.compactMap(\.model),
            summaries: summaries.compactMap(\.model)
        )
    }

    static let mock = HomeCardResponse(
        cards: HomeCardCardPayload.mock,
        summaries: HomeCardSummaryPayload.mock
    )
}

private struct HomeCardSummaryPayload: Codable {
    let image: String
    let title: String
    let description: String
    let value: String
    let tag: String
    let date: TimeInterval

    static let mock: [HomeCardSummaryPayload] = [
        .init(image: "melissa",
              title: Strings.FinancialSummary.transferSent,
              description: Strings.FinancialSummary.transferSentDescription,
              value: "-$ 250.00",
              tag: "transfer",
              date: Date().timeIntervalSince1970),
        .init(image: "ed",
              title: Strings.FinancialSummary.paymentReceived,
              description: Strings.FinancialSummary.paymentReceivedDescription,
              value: "$ 125.00",
              tag: "income",
              date: Date().timeIntervalSince1970),
        .init(image: "NetflixLogo",
              title: Strings.FinancialSummary.netflix,
              description: Strings.FinancialSummary.subscription,
              value: "-$ 20.00",
              tag: "expense",
              date: Calendar.current.date(byAdding: .day, value: -1, to: Date())?.timeIntervalSince1970 ?? Date().timeIntervalSince1970),
        .init(image: "applelogo",
              title: Strings.FinancialSummary.appleBill,
              description: Strings.FinancialSummary.subscription,
              value: "-$ 9.00",
              tag: "expense",
              date: Calendar.current.date(byAdding: .day, value: -5, to: Date())?.timeIntervalSince1970 ?? Date().timeIntervalSince1970)
    ]

    var model: FinancialSummaryModel? {
        guard let type = Self.transactionType(from: tag) else { return nil }
        return FinancialSummaryModel(
            image: image,
            title: title,
            description: description,
            value: value,
            tag: type,
            date: Date(timeIntervalSince1970: date)
        )
    }

    private static func transactionType(from token: String) -> TransactionType? {
        switch token {
        case "income":
            return .income
        case "expense":
            return .expense
        case "transfer":
            return .transfer
        default:
            return nil
        }
    }
}

private struct HomeCardCardPayload: Codable {
    let number: String?
    let validDate: String?
    let name: String?
    let brand: String?
    let style: CreditCardStyle?

    static let mock: [HomeCardCardPayload] = [
        .creditCard(number: "**** **** **** **21",
                    validDate: "09/25",
                    name: Strings.HomeApp.mockCardOwnerOne,
                    brand: Strings.HomeApp.mockVisa,
                    style: .platinum),
        .creditCard(number: "**** **** **** **73",
                    validDate: "02/29",
                    name: Strings.HomeApp.mockCardOwnerTwo,
                    brand: Strings.HomeApp.mockMastercard,
                    style: .black)
    ]

    static func creditCard(number: String,
                           validDate: String,
                           name: String,
                           brand: String,
                           style: CreditCardStyle = .standard) -> HomeCardCardPayload {
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

private struct HomeCardQuickActionPayload: Codable {
    let label: String
    let icon: String

    static let mock: [HomeCardQuickActionPayload] = [
        .init(label: "Send", icon: "paperplane.fill"),
        .init(label: "Request", icon: "arrow.down"),
        .init(label: "Pay", icon: "creditcard.fill"),
        .init(label: "Top up", icon: "plus")
    ]

    var model: CardOptions {
        CardOptions(label: label, icon: icon)
    }
}
