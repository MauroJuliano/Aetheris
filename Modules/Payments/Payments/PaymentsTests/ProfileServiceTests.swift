import Core
import Foundation
import Testing
@testable import Payments

@Suite("ProfileService")
struct ProfileServiceTests {
    @Test
    func loadProfile_returnsMockProfilePayload() async throws {
        let coreService = CoreServiceTestDouble()
        let sut = ProfileService(coreService: coreService)

        let response = try await sut.loadProfile()

        #expect(response.user.firstName == "Melissa")
        #expect(response.user.lastName == "Mccarthy")
        #expect(response.user.avatar == "melissa")
        #expect(response.user.joinedDate == "Joined August 17, 2025")
        #expect(response.general.title == "General")
        #expect(response.general.name == Strings.Profile.userName)
        #expect(response.general.email == Strings.Profile.email)
        #expect(response.general.phone == Strings.Profile.phone)
        #expect(response.general.feedback == "Feedback")
        #expect(response.notifications.hasPushNotificationsActive == true)
        #expect(response.notifications.hasSMSNotificationsActive == false)
        #expect(response.footer.version == Strings.Profile.version)
        #expect(response.footer.poweredBy == Strings.Profile.poweredBy)
        #expect(response.footer.terms == Strings.Profile.terms)
        #expect(coreService.calls == [
            .init(path: "https://api.aetheris.app/payments/profile", method: .get)
        ])
    }

    @Test
    func loadProfile_throwsInvalidData_whenResponseCannotDecode() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.responseData = Data()
        let sut = ProfileService(coreService: coreService)

        do {
            _ = try await sut.loadProfile()
            #expect(Bool(false))
        } catch {
            #expect((error as? CoreServiceError) == .invalidData)
        }
    }

    @Test
    func loadProfile_propagatesCoreServiceErrors() async throws {
        let coreService = CoreServiceTestDouble()
        coreService.error = URLError(.timedOut)
        let sut = ProfileService(coreService: coreService)

        do {
            _ = try await sut.loadProfile()
            #expect(Bool(false))
        } catch {
            let urlError = error as? URLError
            #expect(urlError?.code == .timedOut)
        }
    }
}
