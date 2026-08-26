import Foundation

public struct RecentContactButtonModel: Identifiable, Hashable {
    public let id: UUID
    public let name: String
    public let contactInformation: String
    public let imageName: String?

    public init(id: UUID, name: String, contactInformation: String, imageName: String?) {
        self.id = id
        self.name = name
        self.contactInformation = contactInformation
        self.imageName = imageName
    }

    public var firstName: String {
        name.split(separator: " ").first.map(String.init) ?? name
    }

    public var initials: String {
        name.split(separator: " ").prefix(2).compactMap(\.first).map(String.init).joined().uppercased()
    }
}
