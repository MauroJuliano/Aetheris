import Foundation

struct ResumeListModel: Identifiable {
    enum Kind: Hashable {
        case sin
        case mothersName
        case userName
        case email
        case birthdate
    }

    let id: UUID
    let image: String
    let description: String
    let value: String
    let kind: Kind

    public init(id: UUID = UUID(),
                image: String,
                description: String,
                value: String,
                kind: Kind = .userName) {
        self.id = id
        self.image = image
        self.description = description
        self.value = value
        self.kind = kind
    }

    static let list: [ResumeListModel] = [
        .init(
            image: "person.fill",
            description: Strings.Resume.fullName,
            value: Strings.Resume.mockName,
            kind: .userName
        )
    ]
}
