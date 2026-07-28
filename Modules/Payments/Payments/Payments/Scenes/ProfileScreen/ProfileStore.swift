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

final class ProfileStore {
    var profile: ProfileData = .mock
}
