import Core
import Foundation
import Testing
@testable import Payments

@Suite("TransactionHistoryService")
struct TransactionHistoryServiceTests {
    @Test
    func loadTransactions_returnsMockTransactions() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = TransactionHistoryService(coreService: coreService)

        let transactions = try await sut.loadTransactions()

        #expect(transactions.count == 5)
        #expect(transactions.map(\.title) == [
            Strings.FinancialSummary.transferSent,
            Strings.FinancialSummary.paymentReceived,
            Strings.FinancialSummary.netflix,
            Strings.FinancialSummary.appleBill,
            Strings.FinancialSummary.ifoodBar
        ])
        #expect(transactions.map(\.tag) == [
            .transfer,
            .income,
            .expense,
            .expense,
            .expense
        ])
        #expect(coreService.calls == [
            .init(path: "https://api.aetheris.app/payments/transactions", method: .get)
        ])
    }

    @Test
    func loadTransactions_throwsInvalidData_whenResponseCannotDecode() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data()
        let sut = TransactionHistoryService(coreService: coreService)

        do {
            _ = try await sut.loadTransactions()
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
        }
    }

    @Test
    func loadTransactions_propagatesCoreServiceErrors() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.error = URLError(.cannotFindHost)
        let sut = TransactionHistoryService(coreService: coreService)

        do {
            _ = try await sut.loadTransactions()
            #expect(Bool(false))
        } catch {
            let urlError = error as? URLError
            #expect(urlError?.code == .cannotFindHost)
        }
    }
}
