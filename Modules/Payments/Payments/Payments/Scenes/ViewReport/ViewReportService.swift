import Core
import Foundation

protocol ViewReportServicing {
    func loadReport() async throws -> ViewReportResponse
}

final class ViewReportService: ViewReportServicing {
    private let coreService: any HasCoreService

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func loadReport() async throws -> ViewReportResponse {
        try await coreService.execute(ViewReportEndpoint.report)
    }
}

private enum ViewReportEndpoint {
    case report
}

extension ViewReportEndpoint: Endpoint {
    var path: String {
        "/payments/view-report"
    }

    var method: HTTPMethod { .get }

    var body: Encodable? { nil }

    var mockResponseData: Data {
        switch self {
        case .report:
            return Self.encodeOrEmpty(ViewReportResponse.mock)
        }
    }

    private static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }
}

struct ViewReportResponse: Codable {
    let title: String
    let subtitle: String
    let periodLabel: String
    let totalSpent: String
    let changePercent: Double
    let topCategories: [TopCategory]
}

extension ViewReportResponse {
    struct TopCategory: Codable, Hashable {
        let title: String
        let amount: String
        let percentage: String
    }

    static let mock = ViewReportResponse(
        title: Strings.ViewReport.loadingTitle,
        subtitle: Strings.SpendingChart.title,
        periodLabel: Strings.SpendingChart.comparison,
        totalSpent: "$ 2,428.00",
        changePercent: 8.3,
        topCategories: [
            .init(title: Strings.SpendingChart.shopping, amount: "$ 980.50", percentage: "40%"),
            .init(title: Strings.SpendingChart.bills, amount: "$ 610.00", percentage: "25%"),
            .init(title: Strings.SpendingChart.transport, amount: "$ 420.00", percentage: "17%"),
            .init(title: Strings.SpendingChart.foodAndDrinks, amount: "$ 417.50", percentage: "18%")
        ]
    )
}
