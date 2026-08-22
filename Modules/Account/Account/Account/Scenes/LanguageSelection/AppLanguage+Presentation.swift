import Core

extension AppLanguage {
    var title: String {
        switch self {
        case .system: Strings.Language.systemDefault
        case .english: "English"
        case .german: "Deutsch"
        case .portugueseBrazil: "Português (Brasil)"
        }
    }

    var subtitle: String {
        switch self {
        case .system: Strings.Language.systemDescription
        case .english: Strings.Language.english
        case .german: Strings.Language.german
        case .portugueseBrazil: Strings.Language.portuguese
        }
    }
}
