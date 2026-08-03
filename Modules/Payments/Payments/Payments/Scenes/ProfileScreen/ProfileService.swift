import Core
import Foundation

protocol ProfileServicing {
    func loadProfile() async throws -> ProfileDashboardResponse
    func updateProfile(_ request: UpdateProfileRequest) async throws -> ProfileDashboardResponse
}

final class ProfileService: ProfileServicing {
    private let coreService: any HasCoreService

    init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    func loadProfile() async throws -> ProfileDashboardResponse {
        try await coreService.execute(ProfileEndpoint.profile)
    }

    func updateProfile(_ request: UpdateProfileRequest) async throws -> ProfileDashboardResponse {
        try await coreService.execute(ProfileEndpoint.update(request))
    }
}

struct UpdateProfileRequest: Codable, Equatable {
    let name: String
    let email: String
    let phone: String
}

struct ProfileDashboardResponse: Codable {
    let user: User
    let general: General
    let notifications: Notifications
    let footer: Footer

    struct User: Codable {
        let firstName: String
        let lastName: String
        let avatar: String
        let joinedDate: String
    }

    struct Notifications: Codable {
        let hasPushNotificationsActive: Bool
        let hasSMSNotificationsActive: Bool
    }

    struct General: Codable {
        let title: String
        let name: String
        let email: String
        let phone: String
        let feedback: String
    }

    struct Footer: Codable {
        let version: String
        let poweredBy: String
        let terms: String
    }
}

private enum ProfileEndpoint {
    case profile
    case update(UpdateProfileRequest)
}

extension ProfileEndpoint: Endpoint {
    var path: String {
        switch self {
        case .profile:
            "/payments/profile"
        case .update:
            "/payments/profile/update"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .profile: .get
        case .update: .post
        }
    }

    var body: Encodable? {
        switch self {
        case .profile: nil
        case let .update(request): request
        }
    }

    var mockResponseData: Data {
        switch self {
        case .profile:
            return Self.encodeOrEmpty(ProfileDashboardResponse.mock)
        case let .update(request):
            return Self.encodeOrEmpty(ProfileDashboardResponse.mock.updated(with: request))
        }
    }

    private static func encodeOrEmpty<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }
}

extension ProfileDashboardResponse {
    static let mock = ProfileDashboardResponse(
        user: .init(
            firstName: "Melissa",
            lastName: "Mccarthy",
            avatar: "melissa",
            joinedDate: "Joined August 17, 2025"
        ),
        general: .init(
            title: "General",
            name: Strings.Profile.userName,
            email: Strings.Profile.email,
            phone: Strings.Profile.phone,
            feedback: "Feedback"
        ),
        notifications: .init(
            hasPushNotificationsActive: true,
            hasSMSNotificationsActive: false
        ),
        footer: .init(
            version: Strings.Profile.version,
            poweredBy: Strings.Profile.poweredBy,
            terms: Strings.Profile.terms
        )
    )

    func updated(with request: UpdateProfileRequest) -> ProfileDashboardResponse {
        ProfileDashboardResponse(
            user: user,
            general: .init(
                title: general.title,
                name: request.name,
                email: request.email,
                phone: request.phone,
                feedback: general.feedback
            ),
            notifications: notifications,
            footer: footer
        )
    }
}
