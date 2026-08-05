import Foundation

struct ResumeListModel: Identifiable {
    let id: UUID
    let image: String
    let description: String
    let value: String

    public init(id: UUID = UUID(),
                image: String,
                description: String,
                value: String) {
        self.id = id
        self.image = image
        self.description = description
        self.value = value
    }

    static let list: [ResumeListModel] = [
        .init(image: "person.fill", description: Strings.Resume.fullName, value: Strings.Resume.mockName)
    ]
}
