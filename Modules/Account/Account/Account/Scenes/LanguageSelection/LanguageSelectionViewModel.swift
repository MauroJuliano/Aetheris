import Core
import Foundation

@MainActor
final class LanguageSelectionViewModel: ObservableObject {
    @Published private(set) var selectedLanguage: AppLanguage
    @Published private(set) var isRestartNoticePresented = false

    let languages = AppLanguage.allCases
    private let languageManager: any LanguageManaging

    init(languageManager: any LanguageManaging) {
        self.languageManager = languageManager
        selectedLanguage = languageManager.currentLanguage
    }

    func select(_ language: AppLanguage) {
        guard selectedLanguage != language else { return }
        selectedLanguage = language
        languageManager.setLanguage(language)
        isRestartNoticePresented = true
    }

    func dismissRestartNotice() {
        isRestartNoticePresented = false
    }
}
