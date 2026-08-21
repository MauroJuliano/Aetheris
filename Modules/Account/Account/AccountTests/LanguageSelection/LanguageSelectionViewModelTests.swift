import Core
import Testing
@testable import Account

@MainActor
@Suite("LanguageSelectionViewModel")
struct LanguageSelectionViewModelTests {
    @Test
    func selectPersistsLanguageAndPresentsRestartNotice() {
        let manager = LanguageManagerSpy(currentLanguage: .system)
        let sut = LanguageSelectionViewModel(languageManager: manager)

        sut.select(.portugueseBrazil)

        #expect(sut.selectedLanguage == .portugueseBrazil)
        #expect(manager.selectedLanguages == [.portugueseBrazil])
        #expect(sut.isRestartNoticePresented)
    }

    @Test
    func selectingCurrentLanguageDoesNothing() {
        let manager = LanguageManagerSpy(currentLanguage: .english)
        let sut = LanguageSelectionViewModel(languageManager: manager)

        sut.select(.english)

        #expect(manager.selectedLanguages.isEmpty)
        #expect(!sut.isRestartNoticePresented)
    }
}

private final class LanguageManagerSpy: LanguageManaging {
    var currentLanguage: AppLanguage
    var effectiveLanguage: AppLanguage { currentLanguage == .system ? .english : currentLanguage }
    private(set) var selectedLanguages: [AppLanguage] = []

    init(currentLanguage: AppLanguage) {
        self.currentLanguage = currentLanguage
    }

    func setLanguage(_ language: AppLanguage) {
        currentLanguage = language
        selectedLanguages.append(language)
    }
}
