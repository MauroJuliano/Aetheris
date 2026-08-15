import Foundation

struct RequestContactModel: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    let name: String
    let contactInformation: String
    let imageName: String?

    var firstName: String {
        name
            .split(separator: " ")
            .first
            .map(String.init) ?? name
    }

    var initials: String {
        name
            .split(separator: " ")
            .prefix(2)
            .compactMap(\.first)
            .map(String.init)
            .joined()
            .uppercased()
    }
}
