import Foundation

enum RequestMoneyMode: String, CaseIterable, Identifiable {
    case contact
    case shareLink

    var id: String { rawValue }

    var title: String {
        switch self {
        case .contact:
            return Strings.RequestMoney.contactMode
        case .shareLink:
            return Strings.RequestMoney.shareMode
        }
    }

    var icon: String {
        switch self {
        case .contact:
            return "person"
        case .shareLink:
            return "link"
        }
    }
}
