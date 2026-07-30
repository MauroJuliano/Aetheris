import Core
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
final class ProfileStore {
    private let persistence = AppPersistenceController.shared
    private let record: ProfileRecord

    init() {
        record = persistence.profileRecord()

        if !record.isSeeded {
            record.name = ProfileData.mock.name
            record.email = ProfileData.mock.email
            record.phone = ProfileData.mock.phone
            record.isSeeded = true
            persistence.saveChanges()
        }
    }

    var profile: ProfileData {
        ProfileData(
            name: record.name,
            email: record.email,
            phone: record.phone,
            avatarName: ProfileData.mock.avatarName,
            joinedDate: ProfileData.mock.joinedDate
        )
    }

    func updateName(_ name: String) {
        record.name = name
        persistence.saveChanges()
    }

    func updateEmail(_ email: String) {
        record.email = email
        persistence.saveChanges()
    }

    func updatePhone(_ phone: String) {
        record.phone = phone
        persistence.saveChanges()
    }
}
