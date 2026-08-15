import AetherisDesignSystem
import Combine
import Core
import Foundation

enum ProfileLoadingState: Equatable {
    case initialLoading
    case loaded
    case refreshing
    case refreshFailed
}

enum ProfileUpdateResult: Equatable {
    case success
    case failure(message: String)
}

@MainActor
final class ProfileScreenViewModel: ObservableObject {
    @Published private(set) var loadingState: ProfileLoadingState = .initialLoading
    @Published private(set) var profile: ProfileData
    @Published private(set) var generalCells: [FormCellModel]
    @Published private(set) var notificationCells: [FormCellModel]
    @Published private(set) var footer: ProfileDashboardResponse.Footer

    private let store: any ProfileStoring
    private let service: ProfileServicing

    var isInitialLoading: Bool { loadingState == .initialLoading }
    var isRetrying: Bool { loadingState == .refreshing }
    var hasLoadingError: Bool {
        loadingState == .refreshFailed || loadingState == .refreshing
    }

    init(store: any ProfileStoring, service: ProfileServicing) {
        self.store = store
        self.service = service
        self.profile = store.profile
        self.generalCells = Self.makeGeneralCells(for: store.profile)
        self.notificationCells = Self.makeNotificationCells(pushIsOn: true, smsIsOn: false)
        self.footer = .init(
            version: Strings.Profile.version,
            poweredBy: Strings.Profile.poweredBy,
            terms: Strings.Profile.terms
        )
    }

    func updateName(_ name: String) async -> ProfileUpdateResult {
        var updatedProfile = profile
        updatedProfile.name = name
        return await update(updatedProfile)
    }

    func updateEmail(_ email: String) async -> ProfileUpdateResult {
        var updatedProfile = profile
        updatedProfile.email = email
        return await update(updatedProfile)
    }

    func updatePhone(_ phone: String) async -> ProfileUpdateResult {
        var updatedProfile = profile
        updatedProfile.phone = phone
        return await update(updatedProfile)
    }

    func load() async {
        guard loadingState == .initialLoading else { return }

        do {
            let response = try await service.loadProfile()
            apply(response)
            loadingState = .loaded
        } catch {
            loadingState = .refreshFailed
        }
    }

    func retry() async {
        guard loadingState == .refreshFailed else { return }

        loadingState = .refreshing
        do {
            let response = try await service.loadProfile()
            apply(response)
            loadingState = .loaded
        } catch {
            loadingState = .refreshFailed
        }
    }

    private func update(_ updatedProfile: ProfileData) async -> ProfileUpdateResult {
        let request = UpdateProfileRequest(
            name: updatedProfile.name,
            email: updatedProfile.email,
            phone: updatedProfile.phone
        )

        do {
            let response = try await service.updateProfile(request)
            apply(response)
            return .success
        } catch {
            let serverMessage = (error as? CoreServiceError)?.serverMessage
            return .failure(message: serverMessage ?? Strings.Profile.updateErrorDescription)
        }
    }

    private func apply(_ response: ProfileDashboardResponse) {
        let remoteProfile = ProfileData(
            name: response.general.name,
            email: response.general.email,
            phone: response.general.phone,
            avatarName: response.user.avatar,
            joinedDate: response.user.joinedDate
        )
        store.update(remoteProfile)
        profile = remoteProfile
        generalCells = Self.makeGeneralCells(title: response.general.title, profile: remoteProfile)
        notificationCells = Self.makeNotificationCells(
            pushIsOn: response.notifications.hasPushNotificationsActive,
            smsIsOn: response.notifications.hasSMSNotificationsActive
        )
        footer = response.footer
    }

    private static func makeGeneralCells(for profile: ProfileData) -> [FormCellModel] {
        FormCellModel.profileCells(
            name: profile.name,
            email: profile.email,
            phone: profile.phone
        )
    }

    private static func makeGeneralCells(
        title: String,
        profile: ProfileData
    ) -> [FormCellModel] {
        FormCellModel.profileCells(
            name: profile.name,
            email: profile.email,
            phone: profile.phone
        ).enumerated().map { index, cell in
            FormCellModel(
                sectionTitle: index == 0 ? title : nil,
                content: cell.content
            )
        }
    }

    private static func makeNotificationCells(pushIsOn: Bool, smsIsOn: Bool) -> [FormCellModel] {
        FormCellModel.notificationCells(pushIsOn: pushIsOn, smsIsOn: smsIsOn)
    }
}
