import Core
import Foundation

@MainActor
final class LanguageSelectionViewModel: ObservableObject {
    @Published private(set) var selectedLanguage: AppLanguage
    @Published private(set) var isApplyingLanguage = false

    let languages = AppLanguage.allCases
    private let languageManager: any LanguageManaging
    private let applyDelayNanoseconds: UInt64

    init(
        languageManager: any LanguageManaging,
        applyDelayNanoseconds: UInt64 = 450_000_000
    ) {
        self.languageManager = languageManager
        self.applyDelayNanoseconds = applyDelayNanoseconds
        selectedLanguage = languageManager.currentLanguage
    }

    func select(_ language: AppLanguage) async {
        guard selectedLanguage != language, !isApplyingLanguage else { return }
        isApplyingLanguage = true
        selectedLanguage = language

        try? await Task.sleep(nanoseconds: applyDelayNanoseconds)
        guard !Task.isCancelled else {
            isApplyingLanguage = false
            return
        }

        languageManager.setLanguage(language)
        isApplyingLanguage = false
    }
}
