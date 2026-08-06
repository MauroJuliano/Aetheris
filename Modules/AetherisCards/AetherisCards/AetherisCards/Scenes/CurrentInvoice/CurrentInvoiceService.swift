import Core
import Foundation

protocol CurrentInvoiceServicing {
    func loadInvoice(cardId: UUID) async throws -> CurrentInvoiceDashboard
}

struct CurrentInvoiceDashboard: Codable {
    let invoice: CurrentInvoiceModel
    let summaries: [FinancialSummaryModel]
}

final class CurrentInvoiceService: CurrentInvoiceServicing {
    private let coreService: any HasCoreService

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func loadInvoice(cardId: UUID) async throws -> CurrentInvoiceDashboard {
        try await coreService.execute(CurrentInvoiceEndpoint.dashboard(cardId: cardId))
    }
}

private enum CurrentInvoiceEndpoint {
    case dashboard(cardId: UUID)
}

extension CurrentInvoiceEndpoint: Endpoint {
    var path: String {
        switch self {
        case .dashboard(let cardId):
            return "/payments/cards/\(cardId.uuidString)/current-invoice"
        }
    }

    var method: HTTPMethod { .get }

    var body: Encodable? { nil }

    var mockResponseData: Data {
        switch self {
        case .dashboard(let cardId):
            return Self.encodeOrEmpty(CurrentInvoiceDashboard.mock(cardId: cardId))
        }
    }

    private static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }
}

private extension CurrentInvoiceDashboard {
    static func mock(cardId: UUID) -> CurrentInvoiceDashboard {
        let calendar = Calendar.current
        let dueDate = calendar.date(byAdding: .day, value: 5, to: Date()) ?? Date()
        let bestPurchaseDate = calendar.date(byAdding: .day, value: 15, to: Date()) ?? Date()

        return CurrentInvoiceDashboard(
            invoice: CurrentInvoiceModel(
                id: UUID(),
                cardId: cardId,
                amount: 350,
                status: .open,
                dueDate: dueDate,
                bestPurchaseDate: bestPurchaseDate,
                totalLimit: 5_000,
                availableLimit: 2_750,
                usedLimit: 2_250,
                details: CurrentInvoiceDetailsModel(
                    purchasesSubtotal: 318.50,
                    otherCharges: 31.50,
                    discountsAndCredits: 0,
                    total: 350
                ),
                spendingSummary: InvoiceSpendingSummaryModel(
                    totalSpent: 2_250,
                    installmentPurchases: 1_200,
                    oneTimePurchases: 1_050
                )
            ),
            summaries: [
                FinancialSummaryModel(
                    cardId: cardId,
                    image: "applelogo",
                    title: Strings.FinancialSummary.appleBill,
                    description: Strings.FinancialSummary.subscription,
                    value: "-R$ 29,90",
                    tag: .expense,
                    date: Date()
                ),
                FinancialSummaryModel(
                    cardId: cardId,
                    image: "ifoodlogo",
                    title: Strings.FinancialSummary.ifoodBar,
                    description: Strings.FinancialSummary.restaurant,
                    value: "-R$ 82,40",
                    tag: .expense,
                    date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
                ),
                FinancialSummaryModel(
                    cardId: cardId,
                    image: "NetflixLogo",
                    title: Strings.FinancialSummary.netflix,
                    description: Strings.FinancialSummary.subscription,
                    value: "-R$ 55,90",
                    tag: .expense,
                    date: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date()
                )
            ]
        )
    }
}
