import Foundation
import Testing
@testable import AetherisCards

@MainActor
@Suite("TransactionHistoryViewModel")
struct TransactionHistoryViewModelTests {
    @Test
    func initialState_isLoadingWithNoSections() {
        let sut = TransactionHistoryViewModel(service: TransactionHistoryServiceSpy(result: .success([])))

        #expect(sut.isLoading)
        #expect(!sut.isEmpty)
        #expect(sut.sections.isEmpty)
        #expect(sut.errorMessage == nil)
    }

    @Test
    func load_groupsTransactionsInDisplayOrder() async {
        let calendar = Calendar.current
        let transactions = [
            Self.makeTransaction(title: "Old", date: calendar.date(byAdding: .month, value: -2, to: Date())!),
            Self.makeTransaction(title: "Today", date: Date()),
            Self.makeTransaction(title: "Yesterday", date: calendar.date(byAdding: .day, value: -1, to: Date())!)
        ]
        let sut = TransactionHistoryViewModel(service: TransactionHistoryServiceSpy(result: .success(transactions)))

        await sut.load()

        #expect(sut.sections.map(\.title) == [
            Strings.Notifications.sectionToday,
            Strings.Notifications.sectionYesterday,
            Strings.Notifications.sectionOthers
        ])
        #expect(sut.sections.flatMap(\.items).count == 3)
        #expect(!sut.isLoading)
        #expect(!sut.isEmpty)
    }

    @Test
    func load_marksHistoryEmpty_whenServiceReturnsNoTransactions() async {
        let sut = TransactionHistoryViewModel(service: TransactionHistoryServiceSpy(result: .success([])))

        await sut.load()

        #expect(sut.isEmpty)
        #expect(sut.sections.isEmpty)
        #expect(sut.errorMessage == nil)
    }

    @Test
    func load_setsErrorAndRecoversOnRetry() async {
        let service = TransactionHistoryServiceSpy(results: [
            .failure(URLError(.timedOut)),
            .success([Self.makeTransaction(title: "Recovered", date: Date())])
        ])
        let sut = TransactionHistoryViewModel(service: service)

        await sut.load()
        #expect(sut.errorMessage != nil)

        await sut.load()

        #expect(sut.errorMessage == nil)
        #expect(sut.sections.flatMap(\.items).map(\.title) == ["Recovered"])
        #expect(service.loadCalls == 2)
    }

    private static func makeTransaction(title: String, date: Date) -> FinancialSummaryModel {
        FinancialSummaryModel(
            image: "avatar",
            title: title,
            description: "Description",
            value: "$ 10.00",
            tag: .expense,
            date: date
        )
    }
}

private final class TransactionHistoryServiceSpy: TransactionHistoryServicing {
    enum Result { case success([FinancialSummaryModel]), failure(Error) }
    private var results: [Result]
    private(set) var loadCalls = 0

    init(result: Result) { results = [result] }
    init(results: [Result]) { self.results = results }

    func loadTransactions() async throws -> [FinancialSummaryModel] {
        loadCalls += 1
        switch results.removeFirst() {
        case let .success(transactions): return transactions
        case let .failure(error): throw error
        }
    }
}
