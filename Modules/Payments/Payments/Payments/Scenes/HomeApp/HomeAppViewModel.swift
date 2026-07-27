import AetherisDesignSystem
import Foundation
import SwiftUI

@MainActor
final class HomeAppViewModel: ObservableObject {
    @Published private(set) var isLoading = true
    @Published private(set) var isEmpty = false
    @Published private(set) var errorMessage: String?
    @Published var cards: [Card] = []

    private let service: any HomeAppServicing

    init(service: any HomeAppServicing) {
        self.service = service
    }

    func load() async {
        isLoading = true
        errorMessage = nil
        isEmpty = false

        do {
            cards = try await service.loadCards()
            isEmpty = cards.isEmpty
        } catch {
            errorMessage = "We could not load your cards right now."
        }

        isLoading = false
    }
}
