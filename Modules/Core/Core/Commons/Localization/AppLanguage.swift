import Foundation

public enum AppLanguage: String, CaseIterable, Codable, Identifiable, Sendable {
    case system
    case english
    case german
    case portugueseBrazil

    public var id: String { rawValue }

    public var languageCode: String? {
        switch self {
        case .system: nil
        case .english: "en"
        case .german: "de"
        case .portugueseBrazil: "pt-BR"
        }
    }

    public var locale: Locale {
        guard let languageCode else { return .current }
        return Locale(identifier: languageCode)
    }
}
