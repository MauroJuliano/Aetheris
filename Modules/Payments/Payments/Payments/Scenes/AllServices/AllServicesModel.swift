import Foundation

struct AllServicesItem: Identifiable, Codable {
    enum Theme: String, Codable {
        case primary
        case success
        case info
        case warning
    }

    var id = UUID()
    let title: String
    let subtitle: String
    let icon: String
    let theme: Theme
}
