import Core
import Foundation
import Testing
@testable import AetherisTransfers

@Suite("RequestMoneyService")
struct RequestMoneyServiceTests {
    @Test
    func loadDashboard_returnsMockPayload() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = RequestMoneyService(coreService: coreService)

        let dashboard = try await sut.loadDashboard()

        #expect(dashboard.requesterName == "Blake Brown")
        #expect(dashboard.recentContacts.count == BeneficiaryFixtures.defaults.count)
        #expect(dashboard.recentContacts.map(\.id) == BeneficiaryFixtures.defaults.map(\.id))
        #expect(dashboard.recentContacts.map(\.name) == BeneficiaryFixtures.defaults.map(\.name))
        #expect(dashboard.recentContacts.map(\.imageName) == BeneficiaryFixtures.defaults.map(\.image))
        #expect(dashboard.amountPresets.map(\.value) == [50, 100, 150, 200, 300])
        #expect(coreService.calls == [
            .init(path: "/payments/request-money/dashboard", method: .get)
        ])
    }

    @Test
    func createRequest_postsRequestAndReturnsBackendModel() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = RequestMoneyService(coreService: coreService)
        let contact = BeneficiaryFixtures.defaults[0]

        let request = try await sut.createRequest(
            contactId: contact.id,
            amount: 125,
            reason: "Dinner"
        )

        #expect(request.contact?.id == contact.id)
        #expect(request.contact?.name == contact.name)
        #expect(request.contact?.imageName == contact.image)
        #expect(request.amount == 125)
        #expect(request.reason == "Dinner")
        #expect(request.paymentLink == nil)
        #expect(coreService.calls == [
            .init(path: "/payments/money-requests", method: .post)
        ])
    }

    @Test
    func createSharedRequest_postsRequestAndReturnsPaymentLink() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = RequestMoneyService(coreService: coreService)

        let request = try await sut.createSharedRequest(
            amount: 200,
            reason: "Trip split"
        )

        #expect(request.contact == nil)
        #expect(request.amount == 200)
        #expect(request.reason == "Trip split")
        #expect(request.paymentLink == URL(string: "https://aetheris.app/request/mock"))
        #expect(coreService.calls == [
            .init(path: "/payments/money-requests/share", method: .post)
        ])
    }

    @Test
    func loadDashboard_throwsInvalidData_whenResponseCannotDecode() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data()
        let sut = RequestMoneyService(coreService: coreService)

        do {
            _ = try await sut.loadDashboard()
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
            #expect(coreService.calls.count == 1)
        }
    }
}
