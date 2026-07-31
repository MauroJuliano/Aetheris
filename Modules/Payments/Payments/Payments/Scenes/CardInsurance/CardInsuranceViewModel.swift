import Foundation
import SwiftUI

@MainActor
final class CardInsuranceViewModel: ObservableObject {
    @Published private(set) var isLoading = true
    @Published private(set) var bullets: [CardInsuranceBullet] = []
    @Published private(set) var errorMessage: String?

    private let service: any CardInsuranceServicing

    init(service: any CardInsuranceServicing) {
        self.service = service
    }

    func load() async {
        isLoading = true
        errorMessage = nil

        do {
            bullets = try await service.loadBullets().bullets
        } catch {
            bullets = []
            errorMessage = Strings.Common.errorSubmit
        }

        isLoading = false
    }
}
