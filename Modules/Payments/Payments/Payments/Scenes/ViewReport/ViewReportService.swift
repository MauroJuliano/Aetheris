import Core
import Foundation

protocol ViewReportServicing {
    func loadReport() async throws -> ViewReportModel
}

final class ViewReportService: ViewReportServicing {
    private let coreService: any HasCoreService

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func loadReport() async throws -> ViewReportModel {
        try await coreService.execute(ViewReportEndpoint.report)
    }
}

private enum ViewReportEndpoint {
    case report
}

extension ViewReportEndpoint: Endpoint {
    var path: String {
        "https://api.aetheris.app/payments/view-report"
    }

    var method: HTTPMethod { .get }

    var body: Encodable? { nil }

    var mockResponseData: Data {
        switch self {
        case .report:
            return Self.encodeOrEmpty(ViewReportModel.mock)
        }
    }

    private static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }
}

struct ViewReportModel: Codable {
    let title: String

    static let mock = ViewReportModel(title: Strings.ViewReport.loadingTitle)
}
