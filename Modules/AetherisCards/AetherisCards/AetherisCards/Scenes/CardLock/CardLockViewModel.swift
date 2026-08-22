import Foundation
import UIKit

@MainActor
final class CardLockViewModel: ObservableObject {
    @Published private(set) var card: CardLockModel?
    @Published private(set) var isLoading = false
    @Published private(set) var isUpdatingStatus = false
    @Published private(set) var errorMessage: String?

    private let cardId: UUID
    private let service: CardLockServicing
    private var hasLoaded = false

    var displayedCard: CardLockModel? {
        card ?? (isLoading ? .loadingPlaceholder : nil)
    }

    var confirmationTitle: String {
        guard let card else { return "" }
        return card.isBlocked ? Strings.CardLock.unlockConfirmationTitle : Strings.CardLock.lockConfirmationTitle
    }

    var confirmationButtonTitle: String {
        guard let card else { return "" }
        return card.isBlocked ? Strings.CardLock.unlockCard : Strings.CardLock.lockCard
    }

    var confirmationDescription: String {
        guard let card else { return "" }
        return card.isBlocked ? Strings.CardLock.unlockConfirmationDescription : Strings.CardLock.lockConfirmationDescription
    }

    init(cardId: UUID, service: CardLockServicing) {
        self.cardId = cardId
        self.service = service
    }

    func loadIfNeeded() async {
        guard !hasLoaded else { return }
        await load()
    }

    func load() async {
        guard !isLoading else { return }

        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {
            card = try await service.fetchCardStatus(cardId: cardId)
            hasLoaded = true
        } catch {
            errorMessage = CardServiceErrorMessage.message(
                for: error,
                fallback: Strings.CardLock.unavailableTitle
            )
        }
    }

    func toggleCardStatus() async {
        guard let currentCard = card, !isUpdatingStatus else { return }

        isUpdatingStatus = true
        errorMessage = nil

        defer {
            isUpdatingStatus = false
        }

        do {
            card = try await service.updateCardStatus(
                cardId: currentCard.id,
                isBlocked: !currentCard.isBlocked
            )
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        } catch {
            errorMessage = CardServiceErrorMessage.message(
                for: error,
                fallback: Strings.CardLock.unavailableTitle
            )
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        }
    }
}

private extension CardLockModel {
    static let loadingPlaceholder = CardLockModel(
        id: UUID(), holderName: "Loading", lastFourDigits: "0000",
        expirationDate: "00/00", brand: .visa, style: .aurora, isBlocked: false
    )
}
