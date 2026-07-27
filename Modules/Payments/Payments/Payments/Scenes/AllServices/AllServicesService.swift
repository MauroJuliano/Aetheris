import Core
import Foundation

protocol AllServicesServicing {
    func loadServices() async throws -> [AllServicesItem]
}

final class AllServicesService: AllServicesServicing {
    private let coreService: any HasCoreService

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func loadServices() async throws -> [AllServicesItem] {
        try await coreService.execute(AllServicesEndpoint.services)
    }
}

private enum AllServicesEndpoint {
    case services
}

extension AllServicesEndpoint: Endpoint {
    var path: String {
        "https://api.aetheris.app/payments/all-services"
    }

    var method: HTTPMethod { .get }

    var body: Encodable? { nil }

    var mockResponseData: Data {
        switch self {
        case .services:
            return Self.encodeOrEmpty(AllServicesItem.mock)
        }
    }

    private static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }
}

private extension AllServicesItem {
    static let mock: [AllServicesItem] = [
        .init(
            title: Strings.AllServices.transferMoney,
            subtitle: Strings.SendMoney.title,
            icon: "arrow.right.arrow.left",
            theme: .primary
        ),
        .init(
            title: Strings.AllServices.manageBeneficiaries,
            subtitle: Strings.Recipients.title,
            icon: "person.2.fill",
            theme: .info
        ),
        .init(
            title: Strings.AllServices.cardCenter,
            subtitle: Strings.CardHome.title,
            icon: "creditcard.fill",
            theme: .warning
        ),
        .init(
            title: Strings.AllServices.notifications,
            subtitle: Strings.NotificationsCentre.title,
            icon: "bell.fill",
            theme: .primary
        ),
        .init(
            title: Strings.AllServices.insurance,
            subtitle: Strings.InsuranceOnboarding.moreOptions,
            icon: "shield.checkered",
            theme: .success
        ),
        .init(
            title: Strings.AllServices.reports,
            subtitle: Strings.SpendingChart.viewReport,
            icon: "chart.bar.fill",
            theme: .info
        )
    ]
}
