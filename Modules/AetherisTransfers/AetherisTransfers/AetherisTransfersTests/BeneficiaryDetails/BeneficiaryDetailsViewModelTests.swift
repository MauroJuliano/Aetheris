import Core
import Foundation
import Testing
@testable import AetherisTransfers

@Suite("BeneficiaryDetailsViewModel")
@MainActor
struct BeneficiaryDetailsViewModelTests {
    @Test
    func loadIfNeeded_fetchesBeneficiaryOnlyOnce() async {
        let beneficiary = BeneficiaryDetailsMockStore.beneficiary(for: BeneficiaryFixtures.defaults[1].id)
        let service = BeneficiaryDetailsServiceSpy(beneficiary: beneficiary)
        let sut = BeneficiaryDetailsViewModel(beneficiaryId: beneficiary.id, service: service)

        await sut.loadIfNeeded()
        await sut.loadIfNeeded()

        #expect(service.fetchCallCount == 1)
        #expect(sut.beneficiary?.name == beneficiary.name)
        #expect(sut.errorMessage == nil)
    }

    @Test
    func load_setsErrorWhenServiceFails() async {
        let service = BeneficiaryDetailsServiceSpy(error: CoreServiceError.invalidData)
        let sut = BeneficiaryDetailsViewModel(
            beneficiaryId: BeneficiaryFixtures.defaults[0].id,
            service: service
        )

        await sut.load()

        #expect(sut.beneficiary == nil)
        #expect(sut.errorMessage == Strings.BeneficiaryDetails.unavailableTitle)
    }

    @Test
    func removeBeneficiary_returnsTrueOnSuccess() async {
        let beneficiary = BeneficiaryDetailsMockStore.beneficiary(for: BeneficiaryFixtures.defaults[0].id)
        let service = BeneficiaryDetailsServiceSpy(beneficiary: beneficiary)
        let sut = BeneficiaryDetailsViewModel(beneficiaryId: beneficiary.id, service: service)

        let wasRemoved = await sut.removeBeneficiary()

        #expect(wasRemoved)
        #expect(service.removeCallCount == 1)
        #expect(!sut.isRemoving)
        #expect(sut.actionErrorMessage == nil)
    }

    @Test
    func removeBeneficiary_setsActionErrorOnFailure() async {
        let service = BeneficiaryDetailsServiceSpy(error: CoreServiceError.invalidData)
        let sut = BeneficiaryDetailsViewModel(
            beneficiaryId: BeneficiaryFixtures.defaults[0].id,
            service: service
        )

        let wasRemoved = await sut.removeBeneficiary()

        #expect(!wasRemoved)
        #expect(sut.actionErrorMessage == Strings.BeneficiaryDetails.actionErrorTitle)
    }
}

private final class BeneficiaryDetailsServiceSpy: BeneficiaryDetailsServicing {
    private let beneficiary: BeneficiaryDetailsModel
    private let error: Error?

    private(set) var fetchCallCount = 0
    private(set) var removeCallCount = 0

    init(
        beneficiary: BeneficiaryDetailsModel = BeneficiaryDetailsMockStore.beneficiary(
            for: BeneficiaryFixtures.defaults[0].id
        ),
        error: Error? = nil
    ) {
        self.beneficiary = beneficiary
        self.error = error
    }

    func fetchBeneficiaryDetails(beneficiaryId: UUID) async throws -> BeneficiaryDetailsModel {
        fetchCallCount += 1
        if let error { throw error }
        return beneficiary
    }

    func removeBeneficiary(beneficiaryId: UUID) async throws {
        removeCallCount += 1
        if let error { throw error }
    }
}
