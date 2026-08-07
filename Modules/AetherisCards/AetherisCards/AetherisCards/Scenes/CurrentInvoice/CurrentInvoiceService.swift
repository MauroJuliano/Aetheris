import AetherisDesignSystem
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
        let profile = CurrentInvoiceMockProfile.profile(for: cardId)
        let calendar = Calendar.current
        let dueDate = calendar.date(byAdding: .day, value: profile.dueDateOffset, to: Date()) ?? Date()
        let bestPurchaseDate = calendar.date(byAdding: .day, value: profile.bestPurchaseDateOffset, to: Date()) ?? Date()

        return CurrentInvoiceDashboard(
            invoice: CurrentInvoiceModel(
                id: profile.invoiceId,
                cardId: cardId,
                amount: profile.amount,
                status: profile.status,
                dueDate: dueDate,
                bestPurchaseDate: bestPurchaseDate,
                totalLimit: profile.totalLimit,
                availableLimit: profile.availableLimit,
                usedLimit: profile.usedLimit,
                details: CurrentInvoiceDetailsModel(
                    purchasesSubtotal: profile.purchasesSubtotal,
                    otherCharges: profile.otherCharges,
                    discountsAndCredits: profile.discountsAndCredits,
                    total: profile.amount
                ),
                spendingSummary: InvoiceSpendingSummaryModel(
                    totalSpent: profile.usedLimit,
                    installmentPurchases: profile.installmentPurchases,
                    oneTimePurchases: profile.oneTimePurchases
                )
            ),
            summaries: profile.summaries(cardId: cardId)
        )
    }
}

private struct CurrentInvoiceMockProfile {
    let invoiceId: UUID
    let amount: Decimal
    let status: InvoiceStatus
    let dueDateOffset: Int
    let bestPurchaseDateOffset: Int
    let totalLimit: Decimal
    let availableLimit: Decimal
    let purchasesSubtotal: Decimal
    let otherCharges: Decimal
    let discountsAndCredits: Decimal
    let installmentPurchases: Decimal
    let oneTimePurchases: Decimal
    let transactions: [CurrentInvoiceMockTransaction]

    var usedLimit: Decimal {
        totalLimit - availableLimit
    }

    static func profile(for cardId: UUID) -> CurrentInvoiceMockProfile {
        switch cardId {
        case CardMockIDs.gold:
            return CurrentInvoiceMockProfile(
                invoiceId: UUID(uuidString: "22222222-2222-2222-2222-222222220901")!,
                amount: 1_148.70,
                status: .closed,
                dueDateOffset: 2,
                bestPurchaseDateOffset: 12,
                totalLimit: 8_000,
                availableLimit: 4_620,
                purchasesSubtotal: 1_067.30,
                otherCharges: 81.40,
                discountsAndCredits: 0,
                installmentPurchases: 1_880,
                oneTimePurchases: 1_500,
                transactions: [
                    .init(image: "NetflixLogo", title: Strings.FinancialSummary.netflix, description: Strings.FinancialSummary.subscription, value: "-$ 20.00", dayOffset: -1),
                    .init(image: "applelogo", title: Strings.FinancialSummary.appleBill, description: Strings.FinancialSummary.subscription, value: "-$ 49.90", dayOffset: -3)
                ]
            )
        case CardMockIDs.infinite:
            return CurrentInvoiceMockProfile(
                invoiceId: UUID(uuidString: "33333333-3333-3333-3333-333333330901")!,
                amount: 2_780.40,
                status: .overdue,
                dueDateOffset: -3,
                bestPurchaseDateOffset: 7,
                totalLimit: 15_000,
                availableLimit: 9_150,
                purchasesSubtotal: 2_640,
                otherCharges: 180.40,
                discountsAndCredits: 40,
                installmentPurchases: 3_250,
                oneTimePurchases: 2_600,
                transactions: [
                    .init(image: "Adele", title: Strings.FinancialSummary.transferSent, description: Strings.FinancialSummary.transferSentAdeleDescription, value: "-$ 70.00", dayOffset: -2),
                    .init(image: "ifoodlogo", title: Strings.FinancialSummary.ifoodBar, description: Strings.FinancialSummary.restaurant, value: "-$ 92.30", dayOffset: -5)
                ]
            )
        default:
            return CurrentInvoiceMockProfile(
                invoiceId: UUID(uuidString: "11111111-1111-1111-1111-111111110901")!,
                amount: 350,
                status: .open,
                dueDateOffset: 5,
                bestPurchaseDateOffset: 15,
                totalLimit: 5_000,
                availableLimit: 2_750,
                purchasesSubtotal: 318.50,
                otherCharges: 31.50,
                discountsAndCredits: 0,
                installmentPurchases: 1_200,
                oneTimePurchases: 1_050,
                transactions: [
                    .init(image: "applelogo", title: Strings.FinancialSummary.appleBill, description: Strings.FinancialSummary.subscription, value: "-$ 29.90", dayOffset: 0),
                    .init(image: "ifoodlogo", title: Strings.FinancialSummary.ifoodBar, description: Strings.FinancialSummary.restaurant, value: "-$ 82.40", dayOffset: -1),
                    .init(image: "NetflixLogo", title: Strings.FinancialSummary.netflix, description: Strings.FinancialSummary.subscription, value: "-$ 55.90", dayOffset: -3)
                ]
            )
        }
    }

    func summaries(cardId: UUID) -> [FinancialSummaryModel] {
        transactions.map {
            FinancialSummaryModel(
                cardId: cardId,
                image: $0.image,
                title: $0.title,
                description: $0.description,
                value: $0.value,
                tag: .expense,
                date: Calendar.current.date(byAdding: .day, value: $0.dayOffset, to: Date()) ?? Date()
            )
        }
    }
}

private struct CurrentInvoiceMockTransaction {
    let image: String
    let title: String
    let description: String
    let value: String
    let dayOffset: Int
}
