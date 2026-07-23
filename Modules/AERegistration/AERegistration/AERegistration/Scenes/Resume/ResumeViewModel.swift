import SwiftUI

@MainActor
final class ResumeViewModel: ObservableObject {
    private let draft: RegistrationDraft

    init(draft: RegistrationDraft) {
        self.draft = draft
    }

    var resumeList: [ResumeListModel] {
        [
            .init(image: "lock.fill", description: Strings.Sin.title, value: draft.sin),
            .init(image: "heart.fill", description: Strings.MothersName.title, value: draft.mothersName),
            .init(image: "person.fill", description: Strings.UserName.title, value: draft.userName),
            .init(image: "calendar", description: Strings.Birthdate.title, value: draft.birthdate)
        ]
    }
}
