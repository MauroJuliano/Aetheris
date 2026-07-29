import Core
import Foundation
import SwiftUI

@MainActor
final class RecentRecipientsStore {
    static let shared = RecentRecipientsStore()

    private let persistence = AppPersistenceController.shared

    private init() {}

    func beneficiaries(limit: Int = 4) -> [Beneficiary] {
        let recentRecipients = persistence.recentRecipientRecords(limit: limit)
        let mappedRecipients = recentRecipients.map {
            Beneficiary(
                id: UUID(uuidString: $0.id) ?? UUID(),
                name: $0.name,
                pixKey: $0.pixKey,
                image: $0.image,
                hasDivider: $0.hasDivider
            )
        }

        guard !mappedRecipients.isEmpty else {
            return Array(Beneficiary.beneficiaries.prefix(limit))
        }

        let recentPixKeys = Set(mappedRecipients.map(\.pixKey))
        let remainingDefaults = Beneficiary.beneficiaries.filter { !recentPixKeys.contains($0.pixKey) }
        return Array((mappedRecipients + remainingDefaults).prefix(limit))
    }

    func record(_ beneficiary: Beneficiary) {
        persistence.upsertRecentRecipient(
            id: beneficiary.id.uuidString,
            name: beneficiary.name,
            pixKey: beneficiary.pixKey,
            image: beneficiary.image,
            hasDivider: beneficiary.hasDivider
        )
    }
}

@MainActor
final class BeneficiaryListViewModel: ObservableObject {
    @Published private(set) var isLoading = true
    @Published private(set) var beneficiaries: [Beneficiary]

    init(beneficiaries: [Beneficiary]? = nil) {
        self.beneficiaries = beneficiaries ?? RecentRecipientsStore.shared.beneficiaries()
    }

    func load() async {
        try? await Task.sleep(nanoseconds: 1_500_000_000)
        isLoading = false
    }
}
