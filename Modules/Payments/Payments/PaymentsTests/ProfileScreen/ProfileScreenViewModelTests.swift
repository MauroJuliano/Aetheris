import Foundation
import Testing
@testable import Payments

@MainActor
@Suite("ProfileScreenViewModel")
struct ProfileScreenViewModelTests {
    @Test
    func initialState_usesSessionProfileAndStartsLoading() {
        let store = ProfileStoreSpy(profile: .fixture(name: "Cached"))
        let sut = ProfileScreenViewModel(store: store, service: ProfileServiceSpy())

        #expect(sut.loadingState == .initialLoading)
        #expect(sut.isInitialLoading)
        #expect(!sut.hasLoadingError)
        #expect(sut.profile.name == "Cached")
        #expect(sut.generalCells.count == 4)
        #expect(sut.notificationCells.count == 2)
    }

    @Test
    func load_replacesSessionProfileWithRemoteDashboard() async {
        let store = ProfileStoreSpy(profile: .fixture(name: "Cached"))
        let response = ProfileDashboardResponse.fixture(name: "Remote", email: "remote@example.com", phone: "999")
        let service = ProfileServiceSpy(loadResult: .success(response))
        let sut = ProfileScreenViewModel(store: store, service: service)

        await sut.load()

        #expect(sut.loadingState == .loaded)
        #expect(!sut.isInitialLoading)
        #expect(sut.profile.name == "Remote")
        #expect(sut.profile.email == "remote@example.com")
        #expect(sut.profile.phone == "999")
        #expect(sut.profile.avatarName == "remote-avatar")
        #expect(store.updatedProfiles.map(\.name) == ["Remote"])
        #expect(service.loadCalls == 1)
    }

    @Test
    func load_keepsSessionFallbackAndExposesRefreshError_whenServiceFails() async {
        let store = ProfileStoreSpy(profile: .fixture(name: "Offline User"))
        let service = ProfileServiceSpy(loadResult: .failure(URLError(.timedOut)))
        let sut = ProfileScreenViewModel(store: store, service: service)

        await sut.load()

        #expect(sut.loadingState == .refreshFailed)
        #expect(sut.hasLoadingError)
        #expect(!sut.isRetrying)
        #expect(sut.profile.name == "Offline User")
        #expect(store.updatedProfiles.isEmpty)
        #expect(sut.notificationCells.count == 2)
        #expect(sut.footer.version == Strings.Profile.version)
    }

    @Test
    func retry_replacesCachedContentAndClearsError_whenServiceRecovers() async {
        let store = ProfileStoreSpy(profile: .fixture(name: "Cached"))
        let service = ProfileServiceSpy(loadResult: .failure(URLError(.timedOut)))
        let sut = ProfileScreenViewModel(store: store, service: service)
        await sut.load()
        service.loadResult = .success(.fixture(name: "Recovered"))

        await sut.retry()

        #expect(sut.loadingState == .loaded)
        #expect(!sut.hasLoadingError)
        #expect(sut.profile.name == "Recovered")
        #expect(service.loadCalls == 2)
    }

    @Test
    func retry_keepsCachedContentAndError_whenServiceFailsAgain() async {
        let store = ProfileStoreSpy(profile: .fixture(name: "Cached"))
        let service = ProfileServiceSpy(loadResult: .failure(URLError(.timedOut)))
        let sut = ProfileScreenViewModel(store: store, service: service)
        await sut.load()

        await sut.retry()

        #expect(sut.loadingState == .refreshFailed)
        #expect(sut.hasLoadingError)
        #expect(sut.profile.name == "Cached")
        #expect(service.loadCalls == 2)
    }

    @Test
    func retry_ignoresRequest_whenThereIsNoRefreshError() async {
        let service = ProfileServiceSpy(loadResult: .success(.fixture()))
        let sut = ProfileScreenViewModel(store: ProfileStoreSpy(profile: .fixture()), service: service)
        await sut.load()

        await sut.retry()

        #expect(sut.loadingState == .loaded)
        #expect(service.loadCalls == 1)
    }

    @Test
    func updateName_postsCompleteProfileAndAppliesServerResponse() async {
        let store = ProfileStoreSpy(profile: .fixture())
        let response = ProfileDashboardResponse.fixture(name: "Normalized Name")
        let service = ProfileServiceSpy(updateResult: .success(response))
        let sut = ProfileScreenViewModel(store: store, service: service)

        let succeeded = await sut.updateName("New Name")

        #expect(succeeded)
        #expect(service.updateRequests == [
            .init(name: "New Name", email: "user@example.com", phone: "123")
        ])
        #expect(sut.profile.name == "Normalized Name")
        #expect(store.updatedProfiles.map(\.name) == ["Normalized Name"])
    }

    @Test
    func updateEmail_postsCompleteProfile() async {
        let store = ProfileStoreSpy(profile: .fixture())
        let service = ProfileServiceSpy(updateResult: .success(.fixture(email: "new@example.com")))
        let sut = ProfileScreenViewModel(store: store, service: service)

        let succeeded = await sut.updateEmail("new@example.com")

        #expect(succeeded)
        #expect(service.updateRequests.first?.email == "new@example.com")
    }

    @Test
    func updatePhone_postsCompleteProfile() async {
        let store = ProfileStoreSpy(profile: .fixture())
        let service = ProfileServiceSpy(updateResult: .success(.fixture(phone: "555")))
        let sut = ProfileScreenViewModel(store: store, service: service)

        let succeeded = await sut.updatePhone("555")

        #expect(succeeded)
        #expect(service.updateRequests.first?.phone == "555")
    }

    @Test
    func update_keepsCurrentProfile_whenServiceFails() async {
        let store = ProfileStoreSpy(profile: .fixture(name: "Current"))
        let service = ProfileServiceSpy(updateResult: .failure(URLError(.notConnectedToInternet)))
        let sut = ProfileScreenViewModel(store: store, service: service)

        let succeeded = await sut.updateName("Rejected")

        #expect(!succeeded)
        #expect(sut.profile.name == "Current")
        #expect(store.updatedProfiles.isEmpty)
        #expect(service.updateRequests.map(\.name) == ["Rejected"])
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

private extension ProfileDashboardResponse {
    static func fixture(
        name: String = "User",
        email: String = "user@example.com",
        phone: String = "123"
    ) -> ProfileDashboardResponse {
        ProfileDashboardResponse(
            user: .init(firstName: "Remote", lastName: "User", avatar: "remote-avatar", joinedDate: "Remote joined"),
            general: .init(title: "General", name: name, email: email, phone: phone, feedback: "Feedback"),
            notifications: .init(hasPushNotificationsActive: true, hasSMSNotificationsActive: false),
            footer: .init(version: "Version", poweredBy: "Powered by", terms: "Terms")
        )
    }
}

@MainActor
private final class ProfileStoreSpy: ProfileStoring {
    var profile: ProfileData
    private(set) var updatedProfiles: [ProfileData] = []

    init(profile: ProfileData) { self.profile = profile }

    func update(_ profile: ProfileData) {
        updatedProfiles.append(profile)
        self.profile = profile
    }
}

private final class ProfileServiceSpy: ProfileServicing {
    enum Result { case success(ProfileDashboardResponse), failure(Error) }

    var loadResult: Result
    let updateResult: Result
    private(set) var loadCalls = 0
    private(set) var updateRequests: [UpdateProfileRequest] = []

    init(
        loadResult: Result = .success(.mock),
        updateResult: Result = .success(.mock)
    ) {
        self.loadResult = loadResult
        self.updateResult = updateResult
    }

    func loadProfile() async throws -> ProfileDashboardResponse {
        loadCalls += 1
        return try resolve(loadResult)
    }

    func updateProfile(_ request: UpdateProfileRequest) async throws -> ProfileDashboardResponse {
        updateRequests.append(request)
        return try resolve(updateResult)
    }

    private func resolve(_ result: Result) throws -> ProfileDashboardResponse {
        switch result {
        case let .success(response): return response
        case let .failure(error): throw error
        }
    }
}
