import Foundation
import Testing
@testable import Payments

@MainActor
@Suite("ViewReportViewModel")
struct ViewReportViewModelTests {
    @Test
    func initialState_isNotLoading() {
        let sut = makeSUT(result: .success(.fixture))

        #expect(!sut.isLoading)
    }

    @Test
    func load_callsServiceAndCompletion() async {
        let service = ViewReportServiceSpy(result: .success(.fixture))
        let sut = makeSUT(service: service)

        await withCheckedContinuation { continuation in
            sut.load { continuation.resume() }
        }

        #expect(!sut.isLoading)
        #expect(service.loadCalls == 1)
    }

    @Test
    func load_callsCompletionEvenWhenServiceFails() async {
        let service = ViewReportServiceSpy(result: .failure(URLError(.timedOut)))
        let sut = makeSUT(service: service)

        await withCheckedContinuation { continuation in
            sut.load { continuation.resume() }
        }

        #expect(!sut.isLoading)
        #expect(service.loadCalls == 1)
    }

    @Test
    func load_ignoresDuplicateRequestWhileLoading() async {
        let service = DeferredViewReportService()
        let sut = makeSUT(service: service)
        var completions = 0

        sut.load { completions += 1 }
        sut.load { completions += 1 }
        await service.waitUntilCalled()

        #expect(sut.isLoading)
        let callsWhileLoading = await service.loadCalls
        #expect(callsWhileLoading == 1)

        await service.succeed(.fixture)
        while sut.isLoading { await Task.yield() }

        #expect(completions == 1)
    }

    private func makeSUT(result: ViewReportServiceSpy.Result) -> ViewReportViewModel {
        makeSUT(service: ViewReportServiceSpy(result: result))
    }

    private func makeSUT(service: any ViewReportServicing) -> ViewReportViewModel {
        ViewReportViewModel(service: service, loadingDelayNanoseconds: 0)
    }
}

private extension ViewReportResponse {
    static let fixture = ViewReportResponse.mock
}

private final class ViewReportServiceSpy: ViewReportServicing {
    enum Result { case success(ViewReportResponse), failure(Error) }
    let result: Result
    private(set) var loadCalls = 0

    init(result: Result) { self.result = result }

    func loadReport() async throws -> ViewReportResponse {
        loadCalls += 1
        switch result {
        case let .success(report): return report
        case let .failure(error): throw error
        }
    }
}

private actor DeferredViewReportService: ViewReportServicing {
    private var continuation: CheckedContinuation<ViewReportResponse, Error>?
    private(set) var loadCalls = 0

    func loadReport() async throws -> ViewReportResponse {
        try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
            loadCalls += 1
        }
    }

    func waitUntilCalled() async {
        while loadCalls == 0 { await Task.yield() }
    }

    func succeed(_ report: ViewReportResponse) {
        continuation?.resume(returning: report)
        continuation = nil
    }
}
