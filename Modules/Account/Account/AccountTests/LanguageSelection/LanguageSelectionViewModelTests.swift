import Core
import Testing
@testable import Account

@MainActor
@Suite("LanguageSelectionViewModel")
struct LanguageSelectionViewModelTests {
    @Test
    func selectPersistsAndAppliesLanguage() async {
        let manager = LanguageManagerSpy(currentLanguage: .system)
        let sut = LanguageSelectionViewModel(
            languageManager: manager,
            applyDelayNanoseconds: 0
        )

        await sut.select(.portugueseBrazil)

        #expect(sut.selectedLanguage == .portugueseBrazil)
        #expect(manager.selectedLanguages == [.portugueseBrazil])
        #expect(!sut.isApplyingLanguage)
    }

    @Test
    func selectingCurrentLanguageDoesNothing() async {
        let manager = LanguageManagerSpy(currentLanguage: .english)
        let sut = LanguageSelectionViewModel(languageManager: manager)

        await sut.select(.english)

        #expect(manager.selectedLanguages.isEmpty)
        #expect(!sut.isApplyingLanguage)
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
