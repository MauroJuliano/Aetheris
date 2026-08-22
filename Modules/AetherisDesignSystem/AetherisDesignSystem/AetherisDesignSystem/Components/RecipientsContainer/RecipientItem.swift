import Foundation

public struct RecipientItem: Identifiable, Hashable {
    public let id: UUID
    public let name: String
    public let imageName: String

    public init(id: UUID, name: String, imageName: String) {
        self.id = id
        self.name = name
        self.imageName = imageName
    }
}
