import AetherisDesignSystem
import Core
import SwiftUI

struct LanguageSelectionView: View {
    @StateObject private var viewModel: LanguageSelectionViewModel
    @Environment(\.dismiss) private var dismiss

    init(languageManager: any LanguageManaging) {
        _viewModel = StateObject(wrappedValue: LanguageSelectionViewModel(languageManager: languageManager))
    }

    var body: some View {
        VStack(spacing: 0) {
            NavBar(
                hasBackButton: true,
                model: .init(firstText: Strings.Language.title, hasInitialSpace: false),
                onBack: { dismiss() }
            )
            .padding(.bottom, AppSpacing.small)

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: AppSpacing.large) {
                    Text(Strings.Language.description)
                        .font(AppTypography.body)
                        .foregroundStyle(Color.textSecondaryColor)

                    languageList
                }
                .padding(.bottom, AppSpacing.bottomBarClearance)
            }
        }
        .padding(.horizontal, AppSpacing.screenHorizontal)
        .appScreenBackground()
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .alert(Strings.Language.restartTitle, isPresented: restartNoticeBinding) {
            Button(Strings.Common.ok, role: .cancel) {
                viewModel.dismissRestartNotice()
            }
        } message: {
            Text(Strings.Language.restartDescription)
        }
        .accessibilityIdentifier("languageSelection.screen")
    }

    private var languageList: some View {
        VStack(spacing: 0) {
            ForEach(Array(viewModel.languages.enumerated()), id: \.element.id) { index, language in
                LanguageSelectionCell(
                    language: language,
                    isSelected: viewModel.selectedLanguage == language,
                    onTap: { viewModel.select(language) }
                )

                if index < viewModel.languages.count - 1 {
                    Divider().padding(.leading, AppSpacing.medium)
                }
            }
        }
        .appCardSurface()
    }

    private var restartNoticeBinding: Binding<Bool> {
        Binding(
            get: { viewModel.isRestartNoticePresented },
            set: { if !$0 { viewModel.dismissRestartNotice() } }
        )
    }
}
