import Core
import AetherisDesignSystem
import Foundation

struct ProfileData {
    var name: String
    var email: String
    var phone: String

    static let mock = ProfileData(
        name: Strings.Profile.userName,
        email: Strings.Profile.email,
        phone: Strings.Profile.phone
    )
}

extension ProfileData {
    var generalCells: [FormCellModel] {
        FormCellModel.profileCells(name: name, email: email, phone: phone)
    }
}

@MainActor
final class ProfileStore {
    private let persistence = AppPersistenceController.shared
    private let record: ProfileRecord

    init() {
        record = persistence.profileRecord()

        if !record.isSeeded {
            record.name = Strings.Profile.userName
            record.email = Strings.Profile.email
            record.phone = Strings.Profile.phone
            record.isSeeded = true
            persistence.saveChanges()
        }
    }

    var profile: ProfileData {
        ProfileData(
            name: record.name,
            email: record.email,
            phone: record.phone
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
