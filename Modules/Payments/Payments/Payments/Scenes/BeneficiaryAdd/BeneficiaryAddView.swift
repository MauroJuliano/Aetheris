import AetherisDesignSystem
import SwiftUI

struct BeneficiaryAddView: View {
    @StateObject private var viewModel: BeneficiaryAddViewModel
    let onBack: () -> Void
    let onComplete: (Beneficiary) -> Void

    private let avatarOptions = ["melissa", "ed", "Adele", "Troy", "caroline", "sabrina"]

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

                avatarPicker

                VStack(spacing: AppSpacing.medium) {
                    inputField(title: Strings.BeneficiaryAdd.fullName, text: $viewModel.name, placeholder: Strings.BeneficiaryAdd.fullNamePlaceholder)
                    inputField(title: Strings.BeneficiaryAdd.pixKey, text: $viewModel.pixKey, placeholder: Strings.BeneficiaryAdd.pixKeyPlaceholder)
                }

                previewCard

                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(AppTypography.footnote.weight(.semibold))
                        .foregroundStyle(Color.red)
                }

                Button {
                    guard viewModel.isFormValid, !viewModel.isSaving else { return }
                    Task {
                        guard let beneficiary = await viewModel.save() else { return }
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

                        Text(viewModel.isSaving ? Strings.BeneficiaryAdd.saving : Strings.BeneficiaryAdd.saveBeneficiary)
                            .foregroundStyle(Color.brandPrimaryColor)
                            .font(AppTypography.headline)
                            .appShadow(AppShadow.control)
                    }
                }
                .opacity(viewModel.isFormValid ? 1 : 0.6)
                .disabled(viewModel.isSaving || !viewModel.isFormValid)
            }
            .padding(.horizontal, AppSpacing.screenHorizontal)
            .padding(.bottom, AppSpacing.xxLarge)
        }
        .navigationBarHidden(true)
        .appScreenBackground()
    }

    private var avatarPicker: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text(Strings.BeneficiaryAdd.chooseAvatar)
                .font(AppTypography.headline)
                .foregroundStyle(Color.textPrimary)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppSpacing.medium) {
                    ForEach(avatarOptions, id: \.self) { image in
                        Button {
                            viewModel.selectedImage = image
                        } label: {
                            Image(image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 66, height: 66)
                                .clipShape(Circle())
                                .overlay {
                                    Circle()
                                        .stroke(
                                            viewModel.selectedImage == image ? Color.brandPrimaryColor : Color.clear,
                                            lineWidth: 2
                                        )
                                }
                                .appShadow(AppShadow.card)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.vertical, AppSpacing.xxxSmall)
            }
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

    private var previewCard: some View {
        HStack(spacing: AppSpacing.medium) {
            Image(viewModel.selectedImage)
                .resizable()
                .scaledToFill()
                .frame(width: 58, height: 58)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
                Text(viewModel.name.isEmpty ? Strings.BeneficiaryAdd.previewName : viewModel.name)
                    .font(AppTypography.headline)
                    .foregroundStyle(Color.textPrimary)
                    .lineLimit(1)

                Text(viewModel.pixKey.isEmpty ? Strings.BeneficiaryAdd.previewPixKey : viewModel.pixKey)
                    .font(AppTypography.footnote)
                    .foregroundStyle(Color.textSecondaryColor)
                    .lineLimit(2)
            }

            Spacer()
        }
        .padding(AppSpacing.medium)
        .appCardSurface(
            radius: AppRadius.card,
            stroke: Color.border,
            shadow: AppShadow.card
        )
    }
}
