import Foundation

public struct ContactCardRowModel: Identifiable, Hashable {
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
}
