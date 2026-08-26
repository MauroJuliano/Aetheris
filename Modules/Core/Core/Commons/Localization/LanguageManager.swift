import Foundation

public protocol LanguageManaging: AnyObject {
    var currentLanguage: AppLanguage { get }
    var effectiveLanguage: AppLanguage { get }
    func setLanguage(_ language: AppLanguage)
}

public final class LanguageManager: LanguageManaging {
    private enum Keys {
        static let selectedLanguage = "aetheris.selectedLanguage"
        static let appleLanguages = "AppleLanguages"
    }

    private let defaults: UserDefaults

    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    public var currentLanguage: AppLanguage {
        guard let rawValue = defaults.string(forKey: Keys.selectedLanguage),
              let language = AppLanguage(rawValue: rawValue) else {
            return .system
        }

        return language
    }

    public var effectiveLanguage: AppLanguage {
        guard currentLanguage == .system else { return currentLanguage }

        let preferredLanguage = Locale.preferredLanguages.first ?? "en"
        if preferredLanguage.hasPrefix("pt") { return .portugueseBrazil }
        if preferredLanguage.hasPrefix("de") { return .german }
        return .english
    }

    public func setLanguage(_ language: AppLanguage) {
        defaults.set(language.rawValue, forKey: Keys.selectedLanguage)

        if let languageCode = language.languageCode {
            defaults.set([languageCode], forKey: Keys.appleLanguages)
        } else {
            defaults.removeObject(forKey: Keys.appleLanguages)
        }

        NotificationCenter.default.post(name: .aetherisLanguageDidChange, object: language)
    }
}

public extension Notification.Name {
    static let aetherisLanguageDidChange = Notification.Name("aetheris.languageDidChange")
}
