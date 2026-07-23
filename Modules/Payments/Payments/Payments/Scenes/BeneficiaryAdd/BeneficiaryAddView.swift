import AetherisDesignSystem
import SwiftUI

struct BeneficiaryAddView: View {
    @StateObject private var viewModel: BeneficiaryAddViewModel
    let onBack: () -> Void
    let onComplete: (Beneficiary) -> Void

    init(
        viewModel: BeneficiaryAddViewModel,
        onBack: @escaping () -> Void,
        onComplete: @escaping (Beneficiary) -> Void
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onBack = onBack
        self.onComplete = onComplete
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: AppSpacing.large) {
                NavBar(
                    hasBackButton: true,
                    model: .init(firstText: Strings.BeneficiaryAdd.title, hasInitialSpace: false),
                    onBack: onBack
                )

                VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                    Text(Strings.BeneficiaryAdd.subtitle)
                        .font(AppTypography.onboardingBody)
                        .foregroundStyle(Color.textPrimary)

                    Text(Strings.BeneficiaryAdd.description)
                        .font(AppTypography.subheadline)
                        .foregroundStyle(Color.textSecondaryColor)
                        .lineSpacing(4)
                }

                inputField(
                    title: Strings.BeneficiaryAdd.searchLabel,
                    text: $viewModel.searchTerm,
                    placeholder: Strings.BeneficiaryAdd.searchPlaceholder
                )

                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(AppTypography.footnote.weight(.semibold))
                        .foregroundStyle(Color.red)
                }
            }
            .padding(.horizontal, AppSpacing.screenHorizontal)
            .padding(.bottom, AppSpacing.xxLarge)
        }
        .navigationBarHidden(true)
        .appScreenBackground()
        .safeAreaInset(edge: .bottom) {
            Button {
                guard viewModel.isFormValid, !viewModel.isSearching else { return }
                Task {
                    guard let beneficiary = await viewModel.searchBeneficiary() else { return }
                    onComplete(beneficiary)
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: AppRadius.large)
                        .fill(Color.backgroundColorA)
                        .appShadow(AppShadow.card)
                        .overlay(
                            RoundedRectangle(cornerRadius: AppRadius.pill)
                                .stroke(Color.border, style: .init(lineWidth: 1))
                        )
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)

                    Text(viewModel.isSearching ? Strings.BeneficiaryAdd.searching : Strings.BeneficiaryAdd.searchButton)
                        .foregroundStyle(Color.brandPrimaryColor)
                        .font(AppTypography.headline)
                        .appShadow(AppShadow.control)
                }
            }
            .opacity(viewModel.isFormValid ? 1 : 0.6)
            .disabled(viewModel.isSearching || !viewModel.isFormValid)
            .padding(.horizontal, AppSpacing.screenHorizontal)
            .padding(.top, AppSpacing.small)
            .padding(.bottom, AppSpacing.medium)
            .background(Color.backgroundColorA.opacity(0.96))
        }
    }

    private func inputField(title: String, text: Binding<String>, placeholder: String) -> some View {
        VStack(alignment: .leading, spacing: AppSpacing.xxSmall) {
            Text(title)
                .font(AppTypography.subheadline.weight(.semibold))
                .foregroundStyle(Color.textPrimary)

            TextField(placeholder, text: text)
                .font(AppTypography.input)
                .appInputField(horizontalPadding: 0)
        }
    }
}
