import Foundation

struct Benefits: Identifiable, Codable {
    let id: UUID
    let image: String
    let text: String
    
    init(id: UUID = UUID(), image: String, text: String) {
        self.id = id
        self.image = image
        self.text = text
    }
}
