import AetherisDesignSystem
import Core
import Foundation
import Testing
@testable import AetherisCards

@MainActor
@Suite("CardLockViewModel")
struct CardLockViewModelTests {
    @Test
    func loadIfNeeded_fetchesOnlyOnce() async {
        let service = CardLockServiceSpy(result: .success(Self.makeCard(isBlocked: false)))
        let sut = CardLockViewModel(cardId: CardMockIDs.gold, service: service)

        await sut.loadIfNeeded()
        await sut.loadIfNeeded()

        #expect(service.fetchCalls == 1)
        #expect(sut.card?.id == CardMockIDs.gold)
        #expect(sut.errorMessage == nil)
        #expect(!sut.isLoading)
    }

    @Test
    func load_setsErrorMessage_whenServiceFails() async {
        let service = CardLockServiceSpy(result: .failure(URLError(.timedOut)))
        let sut = CardLockViewModel(cardId: CardMockIDs.gold, service: service)

        await sut.load()

        #expect(sut.card == nil)
        #expect(sut.errorMessage == Strings.CardLock.unavailableTitle)
        #expect(!sut.isLoading)
    }

    @Test
    func toggleCardStatus_updatesCard_andHandlesFailures() async {
        let card = Self.makeCard(isBlocked: false)
        let updatedCard = card.updating(isBlocked: true)
        let service = CardLockServiceSpy(
            result: .success(card),
            updateResult: .success(updatedCard)
        )
        let sut = CardLockViewModel(cardId: CardMockIDs.gold, service: service)

        await sut.load()
        await sut.toggleCardStatus()

        #expect(service.updateCalls == 1)
        #expect(sut.card?.isBlocked == true)
        #expect(!sut.isUpdatingStatus)

        let failingService = CardLockServiceSpy(
            result: .success(card),
            updateResult: .failure(URLError(.cannotConnectToHost))
        )
        let failingSut = CardLockViewModel(cardId: CardMockIDs.gold, service: failingService)

        await failingSut.load()
        await failingSut.toggleCardStatus()

        #expect(failingSut.errorMessage == Strings.CardLock.unavailableTitle)
        #expect(!failingSut.isUpdatingStatus)
    }

    @Test
    func toggleCardStatus_doesNothingWhenCardIsMissing() async {
        let service = CardLockServiceSpy(result: .success(Self.makeCard(isBlocked: false)))
        let sut = CardLockViewModel(cardId: CardMockIDs.gold, service: service)

        await sut.toggleCardStatus()

        #expect(service.updateCalls == 0)
        #expect(!sut.isUpdatingStatus)
    }

    private static func makeCard(isBlocked: Bool) -> CardLockModel {
        CardLockModel(
            id: CardMockIDs.gold,
            holderName: "Blake Lehmann",
            lastFourDigits: "4421",
            expirationDate: "09/29",
            brand: .mastercard,
            style: .gold,
            isBlocked: isBlocked
        )
    }
}

private final class CardLockServiceSpy: CardLockServicing {
    enum Result<Value> {
        case success(Value)
        case failure(Error)
    }

    private let result: Result<CardLockModel>
    private let updateResult: Result<CardLockModel>
    private(set) var fetchCalls = 0
    private(set) var updateCalls = 0

    init(
        result: Result<CardLockModel>,
        updateResult: Result<CardLockModel>? = nil
    ) {
        self.result = result
        self.updateResult = updateResult ?? result
    }

    func fetchCardStatus(cardId: UUID) async throws -> CardLockModel {
        fetchCalls += 1

        switch result {
        case let .success(card):
            return card
        case let .failure(error):
            throw error
        }
    }

    func updateCardStatus(cardId: UUID, isBlocked: Bool) async throws -> CardLockModel {
        updateCalls += 1

        switch updateResult {
        case let .success(card):
            return card.updating(isBlocked: isBlocked)
        case let .failure(error):
            throw error
        }
    }
}
