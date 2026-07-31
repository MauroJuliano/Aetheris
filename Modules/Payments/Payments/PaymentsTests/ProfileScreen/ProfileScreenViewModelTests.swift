import Foundation
import Testing
@testable import Payments

@MainActor
@Suite("ProfileScreenViewModel")
struct ProfileScreenViewModelTests {
    @Test
    func initialState_usesStoredProfileAndStartsLoading() {
        let store = ProfileStoreSpy(profile: .fixture(name: "Stored"))
        let sut = ProfileScreenViewModel(store: store, service: ProfileServiceSpy(result: .success(.mock)))

        #expect(sut.isLoading)
        #expect(sut.profile.name == "Stored")
        #expect(sut.generalCells.count == 4)
        #expect(sut.notificationCells.count == 2)
    }

    @Test
    func load_mapsRemoteDashboardWhilePreservingStoredContactData() async {
        let store = ProfileStoreSpy(profile: .fixture(name: "Stored Name", email: "stored@example.com", phone: "555"))
        let service = ProfileServiceSpy(result: .success(.mock))
        let sut = ProfileScreenViewModel(store: store, service: service)

        await sut.load()

        #expect(!sut.isLoading)
        #expect(sut.profile.name == "Stored Name")
        #expect(sut.profile.email == "stored@example.com")
        #expect(sut.profile.phone == "555")
        #expect(sut.profile.avatarName == "melissa")
        #expect(sut.footer.version == Strings.Profile.version)
        #expect(service.loadCalls == 1)
    }

    @Test
    func load_usesRemoteName_whenStoredNameIsEmpty() async {
        let store = ProfileStoreSpy(profile: .fixture(name: "", email: "", phone: ""))
        let sut = ProfileScreenViewModel(store: store, service: ProfileServiceSpy(result: .success(.mock)))

        await sut.load()

        #expect(sut.profile.name == "Melissa Mccarthy")
        #expect(sut.profile.email == Strings.Profile.email)
        #expect(sut.profile.phone == Strings.Profile.phone)
    }

    @Test
    func load_restoresStoredFallback_whenServiceFails() async {
        let stored = ProfileData.fixture(name: "Offline User")
        let store = ProfileStoreSpy(profile: stored)
        let sut = ProfileScreenViewModel(store: store, service: ProfileServiceSpy(result: .failure(URLError(.timedOut))))

        await sut.load()

        #expect(!sut.isLoading)
        #expect(sut.profile.name == "Offline User")
        #expect(sut.notificationCells.count == 2)
        #expect(sut.footer.version == Strings.Profile.version)
    }

    @Test
    func updateMethodsPersistAndRefreshProfile() {
        let store = ProfileStoreSpy(profile: .fixture())
        let sut = ProfileScreenViewModel(store: store, service: ProfileServiceSpy(result: .success(.mock)))

        sut.updateName("New Name")
        sut.updateEmail("new@example.com")
        sut.updatePhone("999")

        #expect(sut.profile.name == "New Name")
        #expect(sut.profile.email == "new@example.com")
        #expect(sut.profile.phone == "999")
        #expect(store.updatedNames == ["New Name"])
        #expect(store.updatedEmails == ["new@example.com"])
        #expect(store.updatedPhones == ["999"])
        #expect(sut.generalCells.count == 4)
    }
}

private extension ProfileData {
    static func fixture(
        name: String = "User",
        email: String = "user@example.com",
        phone: String = "123"
    ) -> ProfileData {
        ProfileData(name: name, email: email, phone: phone, avatarName: "avatar", joinedDate: "Joined")
    }
}

@MainActor
private final class ProfileStoreSpy: ProfileStoring {
    var profile: ProfileData
    private(set) var updatedNames: [String] = []
    private(set) var updatedEmails: [String] = []
    private(set) var updatedPhones: [String] = []

    init(profile: ProfileData) { self.profile = profile }

    func updateName(_ name: String) { updatedNames.append(name); profile.name = name }
    func updateEmail(_ email: String) { updatedEmails.append(email); profile.email = email }
    func updatePhone(_ phone: String) { updatedPhones.append(phone); profile.phone = phone }
}

private final class ProfileServiceSpy: ProfileServicing {
    enum Result { case success(ProfileDashboardResponse), failure(Error) }
    let result: Result
    private(set) var loadCalls = 0

    init(result: Result) { self.result = result }

    func loadProfile() async throws -> ProfileDashboardResponse {
        loadCalls += 1
        switch result {
        case let .success(profile): return profile
        case let .failure(error): throw error
        }
    }
}
