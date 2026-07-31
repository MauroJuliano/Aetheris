import Core
import Foundation
import Testing
@testable import Payments

@Suite("ViewReportService")
struct ViewReportServiceTests {
    @Test
    func loadReport_returnsMockPayload() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = ViewReportService(coreService: coreService)

        let report = try await sut.loadReport()

        #expect(report.title == Strings.ViewReport.loadingTitle)
        #expect(report.topCategories.count == 4)
        #expect(coreService.calls == [
            .init(path: "https://api.aetheris.app/payments/view-report", method: .get)
        ])
    }

    @Test
    func loadReport_throwsInvalidData_whenResponseCannotDecode() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data()
        let sut = ViewReportService(coreService: coreService)

        do {
            _ = try await sut.loadReport()
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
            #expect(coreService.calls.count == 1)
        }
    }

    @Test
    func loadReport_throwsInvalidData_whenResponseHasUnexpectedShape() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data(#"{"title":12}"#.utf8)
        let sut = ViewReportService(coreService: coreService)

        do {
            _ = try await sut.loadReport()
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
            #expect(coreService.calls.count == 1)
        }
    }

    @Test
    func loadReport_propagatesCoreServiceErrors() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.error = URLError(.cannotConnectToHost)
        let sut = ViewReportService(coreService: coreService)

        do {
            _ = try await sut.loadReport()
            #expect(Bool(false))
        } catch {
            let urlError = error as? URLError
            #expect(urlError?.code == .cannotConnectToHost)
            #expect(coreService.calls.count == 1)
        }
    }
}
