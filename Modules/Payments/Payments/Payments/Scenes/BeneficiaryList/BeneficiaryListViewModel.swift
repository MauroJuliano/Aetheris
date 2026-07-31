import Core
import Foundation
import SwiftUI

@MainActor
protocol RecentRecipientsProviding {
    func beneficiaries(limit: Int, fallback: [Beneficiary]) -> [Beneficiary]
}

@MainActor
final class RecentRecipientsStore: RecentRecipientsProviding {
    static let shared = RecentRecipientsStore()

    private let persistence = AppPersistenceController.shared

    private init() {}

    func beneficiaries(limit: Int = 4, fallback: [Beneficiary] = BeneficiaryFixtures.defaults) -> [Beneficiary] {
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
            return Array(fallback.prefix(limit))
        }

        let recentPixKeys = Set(mappedRecipients.map(\.pixKey))
        let remainingDefaults = fallback.filter { !recentPixKeys.contains($0.pixKey) }
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

    private let service: any BeneficiaryListServicing
    private let recentRecipientsStore: any RecentRecipientsProviding

    init(
        service: any BeneficiaryListServicing,
        recentRecipientsStore: (any RecentRecipientsProviding)? = nil
    ) {
        let recentRecipientsStore = recentRecipientsStore ?? RecentRecipientsStore.shared
        self.service = service
        self.recentRecipientsStore = recentRecipientsStore
        self.beneficiaries = recentRecipientsStore.beneficiaries(
            limit: 4,
            fallback: BeneficiaryFixtures.defaults
        )
    }

    func load() async {
        do {
            let response = try await service.loadBeneficiaryList()
            beneficiaries = recentRecipientsStore.beneficiaries(
                limit: 4,
                fallback: response.beneficiaries
            )
        } catch {
            beneficiaries = recentRecipientsStore.beneficiaries(
                limit: 4,
                fallback: BeneficiaryFixtures.defaults
            )
        }
        isLoading = false
    }
}
