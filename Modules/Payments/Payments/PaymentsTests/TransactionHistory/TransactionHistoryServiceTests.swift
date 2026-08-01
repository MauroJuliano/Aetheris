import Core
import Foundation
import Testing
@testable import Payments

@Suite("TransactionHistoryService")
struct TransactionHistoryServiceTests {
    private let cardId = UUID(uuidString: "11111111-1111-1111-1111-111111111111")!

    @Test
    func loadTransactions_returnsMockTransactions() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = TransactionHistoryService(coreService: coreService, cardId: cardId)

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
            .init(path: "https://api.aetheris.app/payments/transactions?cardId=11111111-1111-1111-1111-111111111111", method: .get)
        ])
    }

    @Test
    func loadTransactions_throwsInvalidData_whenResponseCannotDecode() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data()
        let sut = TransactionHistoryService(coreService: coreService, cardId: cardId)

        do {
            _ = try await sut.loadTransactions()
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
            #expect(coreService.calls.count == 1)
        }
    }

    @Test
    func loadTransactions_throwsInvalidData_whenResponseHasUnexpectedShape() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data(#"{"transactions":{}}"#.utf8)
        let sut = TransactionHistoryService(coreService: coreService, cardId: cardId)

        do {
            _ = try await sut.loadTransactions()
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
            #expect(coreService.calls.count == 1)
        }
    }

    @Test
    func loadTransactions_propagatesCoreServiceErrors() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.error = URLError(.cannotFindHost)
        let sut = TransactionHistoryService(coreService: coreService, cardId: cardId)

        do {
            _ = try await sut.loadTransactions()
            #expect(Bool(false))
        } catch {
            let urlError = error as? URLError
            #expect(urlError?.code == .cannotFindHost)
            #expect(coreService.calls.count == 1)
        }
    }
}
