import AetherisDesignSystem
import Foundation

struct ProfileData {
    var name: String
    var email: String
    var phone: String
    var avatarName: String
    var joinedDate: String

    static let mock = ProfileData(
        name: Strings.Profile.userName,
        email: Strings.Profile.email,
        phone: Strings.Profile.phone,
        avatarName: "melissa",
        joinedDate: "Joined August 17, 2025"
    )
}

@MainActor
protocol ProfileStoring {
    var profile: ProfileData { get }
    func update(_ profile: ProfileData)
}

@MainActor
final class ProfileStore: ProfileStoring {
    private(set) var profile: ProfileData

    init(profile: ProfileData = .mock) {
        self.profile = profile
    }

    func update(_ profile: ProfileData) {
        self.profile = profile
    }
}
