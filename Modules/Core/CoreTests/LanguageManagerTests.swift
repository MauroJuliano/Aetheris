import Foundation
import Testing
@testable import Core

@Suite("LanguageManager")
struct LanguageManagerTests {
    @Test
    func defaultsToSystemAndPersistsExplicitSelection() {
        let suiteName = "LanguageManagerTests.\(UUID().uuidString)"
        let defaults = UserDefaults(suiteName: suiteName)!
        defer { defaults.removePersistentDomain(forName: suiteName) }
        let sut = LanguageManager(defaults: defaults)

        #expect(sut.currentLanguage == .system)

        sut.setLanguage(.german)

        #expect(sut.currentLanguage == .german)
        #expect(defaults.stringArray(forKey: "AppleLanguages") == ["de"])
    }

    @Test
    func selectingSystemRemovesLanguageOverride() {
        let suiteName = "LanguageManagerTests.\(UUID().uuidString)"
        let defaults = UserDefaults(suiteName: suiteName)!
        defer { defaults.removePersistentDomain(forName: suiteName) }
        let sut = LanguageManager(defaults: defaults)

        sut.setLanguage(.portugueseBrazil)
        sut.setLanguage(.system)

        #expect(sut.currentLanguage == .system)
        #expect(defaults.persistentDomain(forName: suiteName)?["AppleLanguages"] == nil)
    }
}
