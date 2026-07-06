import SwiftUI

class ResumeViewModel: ObservableObject {
    @Published private(set) var resume: ResumeModel?
    
    var resumeList: [ResumeListModel] {
        guard let resume else { return [] }
        
        return [
            .init(image: "person.fill", description: "Full Name", value: resume.name),
            .init(image: "heart.fill", description: "Mother's Name", value: resume.mothersName),
            .init(image: "calendar", description: "Birthdate", value: resume.birthDate),
            .init(image: "lock.fill", description: "SIN", value: resume.sin)
        ]
    }
    
    func load() async {
        resume = ResumeModel.mock
    }
}
