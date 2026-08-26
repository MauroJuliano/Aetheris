import Foundation

public struct RecentContactItemModel: Identifiable, Hashable {
    public let id: UUID
    public let name: String
    public let imageName: String?

    public init(id: UUID, name: String, imageName: String?) {
        self.id = id
        self.name = name
        self.imageName = imageName
    }

    public var firstName: String {
        name.split(separator: " ").first.map(String.init) ?? name
    }

    public var initials: String {
        name.split(separator: " ").prefix(2).compactMap(\.first).map(String.init).joined().uppercased()
    }
}
