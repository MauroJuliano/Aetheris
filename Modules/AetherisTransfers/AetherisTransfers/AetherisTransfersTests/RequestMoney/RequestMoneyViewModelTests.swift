import Foundation
import Testing
@testable import AetherisTransfers

@Suite("RequestMoneyViewModel")
@MainActor
struct RequestMoneyViewModelTests {
    @Test
    func load_setsDashboardData_whenServiceSucceeds() async {
        let dashboard = RequestMoneyDashboard.fixture(defaultReason: "Dinner")
        let service = RequestMoneyServiceSpy(dashboardResult: .success(dashboard))
        let sut = RequestMoneyViewModel(service: service)

        await sut.load()

        #expect(sut.requesterName == "Blake Brown")
        #expect(sut.recentContacts == dashboard.recentContacts)
        #expect(sut.amountPresets == dashboard.amountPresets)
        #expect(sut.reason == "Dinner")
        #expect(service.loadCalls == 1)
    }

    @Test
    func load_exposesError_whenServiceFails() async {
        let service = RequestMoneyServiceSpy(dashboardResult: .failure(URLError(.timedOut)))
        let sut = RequestMoneyViewModel(service: service)

        await sut.load()

        #expect(sut.recentContacts.isEmpty)
        #expect(sut.loadingErrorMessage != nil)
    }

    @Test
    func canSubmit_requiresContactInContactMode() {
        let sut = RequestMoneyViewModel(service: RequestMoneyServiceSpy())

        sut.selectPreset(100)

        #expect(!sut.canSubmit)

        sut.selectContact(.marina)

        #expect(sut.canSubmit)
    }

    @Test
    func canSubmit_allowsShareLinkWithoutContact() {
        let sut = RequestMoneyViewModel(service: RequestMoneyServiceSpy())

        sut.selectMode(.shareLink)
        sut.selectPreset(100)

        #expect(sut.canSubmit)
    }

    @Test
    func submit_createsContactRequest_whenContactModeIsSelected() async throws {
        let service = RequestMoneyServiceSpy()
        let sut = RequestMoneyViewModel(service: service)

        sut.selectContact(.marina)
        sut.selectPreset(150)
        sut.reason = "Lunch"

        let request = try #require(await sut.submit())

        #expect(service.createRequestCalls == 1)
        #expect(service.createSharedRequestCalls == 0)
        #expect(request.contact == .marina)
        #expect(request.amount == 150)
        #expect(request.reason == "Lunch")
    }

    @Test
    func submit_createsSharedRequest_whenShareModeIsSelected() async throws {
        let service = RequestMoneyServiceSpy()
        let sut = RequestMoneyViewModel(service: service)

        sut.selectMode(.shareLink)
        sut.selectPreset(200)

        let request = try #require(await sut.submit())

        #expect(service.createRequestCalls == 0)
        #expect(service.createSharedRequestCalls == 1)
        #expect(request.contact == nil)
        #expect(request.paymentLink != nil)
        #expect(request.amount == 200)
    }
}

private extension RequestMoneyDashboard {
    static func fixture(defaultReason: String? = nil) -> RequestMoneyDashboard {
        RequestMoneyDashboard(
            requesterName: "Blake Brown",
            recentContacts: [.marina, .lucas],
            amountPresets: [
                RequestMoneyAmountPresetModel(id: "preset_100", value: 100, title: "R$ 100"),
                RequestMoneyAmountPresetModel(id: "preset_200", value: 200, title: "R$ 200")
            ],
            defaultReason: defaultReason
        )
    }
}

private extension RequestContactModel {
    static let marina = RequestContactModel(
        id: UUID(uuidString: "51CE8568-0922-4893-A112-DAAE87B7D650")!,
        name: "Marina Silva",
        contactInformation: "(11) 98765-4321",
        imageName: "marina"
    )

    static let lucas = RequestContactModel(
        id: UUID(uuidString: "0E72F341-8A26-4224-A4CC-07C9775C9B00")!,
        name: "Lucas Almeida",
        contactInformation: "(11) 97654-3210",
        imageName: "lucas"
    )
}

private final class RequestMoneyServiceSpy: RequestMoneyServicing {
    enum Result {
        case success(RequestMoneyDashboard)
        case failure(Error)
    }

    let dashboardResult: Result
    private(set) var loadCalls = 0
    private(set) var createRequestCalls = 0
    private(set) var createSharedRequestCalls = 0

    init(dashboardResult: Result = .success(.fixture())) {
        self.dashboardResult = dashboardResult
    }

    func loadDashboard() async throws -> RequestMoneyDashboard {
        loadCalls += 1

        switch dashboardResult {
        case .success(let dashboard):
            return dashboard
        case .failure(let error):
            throw error
        }
    }

    func createRequest(
        contactId: UUID,
        amount: Decimal,
        reason: String?
    ) async throws -> MoneyRequestModel {
        createRequestCalls += 1

        return MoneyRequestModel(
            id: UUID(),
            contact: .marina,
            amount: amount,
            reason: reason,
            paymentLink: nil,
            createdAt: Date(),
            status: .pending
        )
    }

    func createSharedRequest(
        amount: Decimal,
        reason: String?
    ) async throws -> MoneyRequestModel {
        createSharedRequestCalls += 1

        return MoneyRequestModel(
            id: UUID(),
            contact: nil,
            amount: amount,
            reason: reason,
            paymentLink: URL(string: "https://aetheris.app/request/mock"),
            createdAt: Date(),
            status: .pending
        )
    }
}
