import Foundation

protocol VirtualCardServiceProtocol {
    func fetchVirtualCard(physicalCardId: UUID) async throws -> VirtualCardModel
    func fetchSummaries(physicalCardId: UUID) async throws -> [FinancialSummaryModel]
    func updateCardStatus(cardId: UUID, isActive: Bool) async throws -> VirtualCardModel
    func generateNewCardNumber(cardId: UUID) async throws -> VirtualCardModel
}

final class VirtualCardServiceMock: VirtualCardServiceProtocol {
    private let physicalCardId: UUID

    init(physicalCardId: UUID) {
        self.physicalCardId = physicalCardId
    }

    func fetchVirtualCard(physicalCardId: UUID) async throws -> VirtualCardModel {
        try await Task.sleep(nanoseconds: 500_000_000)
        return makeCard(physicalCardId: physicalCardId, cardNumber: "4589123412344421", securityCode: "123", isActive: true)
    }

    func fetchSummaries(physicalCardId: UUID) async throws -> [FinancialSummaryModel] {
        try await Task.sleep(nanoseconds: 300_000_000)

        return [
            FinancialSummaryModel(
                cardId: physicalCardId,
                image: "creditcard",
                title: "Apple.Com/Bill",
                description: "Assinatura",
                value: "-R$ 29,90",
                tag: .expense,
                date: Date()
            ),
            FinancialSummaryModel(
                cardId: physicalCardId,
                image: "creditcard",
                title: "Netflix",
                description: "Streaming",
                value: "-R$ 55,90",
                tag: .expense,
                date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date()
            )
        ]
    }

    func updateCardStatus(cardId: UUID, isActive: Bool) async throws -> VirtualCardModel {
        try await Task.sleep(nanoseconds: 400_000_000)
        return makeCard(id: cardId, physicalCardId: physicalCardId, cardNumber: "4589123412344421", securityCode: "123", isActive: isActive)
    }

    func generateNewCardNumber(cardId: UUID) async throws -> VirtualCardModel {
        try await Task.sleep(nanoseconds: 800_000_000)
        return makeCard(id: cardId, physicalCardId: physicalCardId, cardNumber: "4589123412349918", securityCode: "872", isActive: true)
    }

    private func makeCard(
        id: UUID = UUID(),
        physicalCardId: UUID,
        cardNumber: String,
        securityCode: String,
        isActive: Bool
    ) -> VirtualCardModel {
        VirtualCardModel(
            id: id,
            physicalCardId: physicalCardId,
            holderName: "Jorge Henrique",
            cardNumber: cardNumber,
            expirationDate: "09/29",
            securityCode: securityCode,
            brand: .visa,
            availableLimit: 2_750,
            totalLimit: 5_000,
            monthlyExpenses: 250,
            isActive: isActive
        )
    }
}
