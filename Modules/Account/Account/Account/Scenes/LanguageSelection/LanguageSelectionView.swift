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
        .overlay {
            if viewModel.isApplyingLanguage {
                applyingLanguageOverlay
            }
        }
        .accessibilityIdentifier("languageSelection.screen")
    }

    private var languageList: some View {
        VStack(spacing: 0) {
            ForEach(Array(viewModel.languages.enumerated()), id: \.element.id) { index, language in
                LanguageSelectionCell(
                    language: language,
                    isSelected: viewModel.selectedLanguage == language,
                    isEnabled: !viewModel.isApplyingLanguage,
                    onTap: {
                        Task { await viewModel.select(language) }
                    }
                )

                if index < viewModel.languages.count - 1 {
                    Divider().padding(.leading, AppSpacing.medium)
                }
            }
        }
        .appCardSurface()
    }

    private var applyingLanguageOverlay: some View {
        ZStack {
            Color.black.opacity(0.28)
                .ignoresSafeArea()

            VStack(spacing: AppSpacing.medium) {
                ProgressView()
                    .controlSize(.large)
                    .tint(Color.brandPrimaryColor)

                Text(Strings.Language.applying)
                    .font(AppTypography.body)
                    .bold()
                    .foregroundStyle(Color.textPrimary)
            }
            .padding(AppSpacing.large)
            .appCardSurface()
        }
        .transition(.opacity)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Strings.Language.applying)
    }
}
