import AetherisDesignSystem
import Combine
import Foundation

@MainActor
final class ProfileScreenViewModel: ObservableObject {
    @Published private(set) var isLoading = true
    @Published private(set) var profile: ProfileData
    @Published private(set) var generalCells: [FormCellModel]
    @Published private(set) var notificationCells: [FormCellModel]
    @Published private(set) var footer: ProfileDashboardResponse.Footer

    private let store: any ProfileStoring
    private let service: ProfileServicing

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

    func updateName(_ name: String) {
        store.updateName(name)
        profile.name = name
        refreshGeneralCells()
    }

    func updateEmail(_ email: String) {
        store.updateEmail(email)
        profile.email = email
        refreshGeneralCells()
    }

    func updatePhone(_ phone: String) {
        store.updatePhone(phone)
        profile.phone = phone
        refreshGeneralCells()
    }

    func load() async {
        do {
            let response = try await service.loadProfile()
            let storedProfile = store.profile

            profile = ProfileData(
                name: storedProfile.name.isEmpty ? "\(response.user.firstName) \(response.user.lastName)" : storedProfile.name,
                email: storedProfile.email.isEmpty ? Strings.Profile.email : storedProfile.email,
                phone: storedProfile.phone.isEmpty ? Strings.Profile.phone : storedProfile.phone,
                avatarName: response.user.avatar,
                joinedDate: response.user.joinedDate
            )
            generalCells = Self.makeGeneralCells(
                title: response.general.title,
                profile: profile
            )
            notificationCells = Self.makeNotificationCells(
                pushIsOn: response.notifications.hasPushNotificationsActive,
                smsIsOn: response.notifications.hasSMSNotificationsActive
            )
            footer = response.footer
        } catch {
            profile = store.profile
            generalCells = Self.makeGeneralCells(for: store.profile)
            notificationCells = Self.makeNotificationCells(pushIsOn: false, smsIsOn: false)
            footer = .init(
                version: Strings.Profile.version,
                poweredBy: Strings.Profile.poweredBy,
                terms: Strings.Profile.terms
            )
        }
        isLoading = false
    }

    private func refreshGeneralCells() {
        generalCells = Self.makeGeneralCells(for: profile)
    }

    private static func makeGeneralCells(for profile: ProfileData) -> [FormCellModel] {
        makeGeneralCells(
            title: "General",
            profile: profile
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
        [
            FormCellModel(
                sectionTitle: "Notifications",
                content: .init(
                    kind: .pushNotifications,
                    title: "Push notifications",
                    icon: "message.badge",
                    hasDivider: true,
                    toggle: .init(isOn: pushIsOn),
                    showsDisclosureIndicator: false
                )
            ),
            FormCellModel(
                sectionTitle: nil,
                content: .init(
                    kind: .smsNotifications,
                    title: "SMS notifications",
                    icon: "text.bubble",
                    hasDivider: false,
                    toggle: .init(isOn: smsIsOn),
                    showsDisclosureIndicator: false
                )
            )
        ]
    }
}
