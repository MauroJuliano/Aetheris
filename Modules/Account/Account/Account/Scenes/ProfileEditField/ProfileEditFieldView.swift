import AetherisDesignSystem
import SwiftUI

struct ProfileEditFieldView: View {
    let title: String
    let description: String
    let initialValue: String
    let placeholder: String
    let onSave: (String) async -> ProfileUpdateResult

    @Environment(\.dismiss) private var dismiss
    @State private var draft: String
    @State private var isSaving = false
    @State private var errorMessage: String?

    init(
        title: String,
        description: String,
        initialValue: String,
        placeholder: String,
        onSave: @escaping (String) async -> ProfileUpdateResult
    ) {
        self.title = title
        self.description = description
        self.initialValue = initialValue
        self.placeholder = placeholder
        self.onSave = onSave
        _draft = State(initialValue: initialValue)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.large) {
            NavBar(
                hasNotifications: false,
                hasBackButton: true,
                model: .init(firstText: title, hasInitialSpace: false),
                onBack: { dismiss() }
            )

            VStack(alignment: .leading, spacing: AppSpacing.large) {
                Text(description)
                    .font(AppTypography.subheadline)
                    .foregroundStyle(Color.textSecondaryColor)

                TextField(placeholder, text: $draft)
                    .font(AppTypography.input)
                    .appInputField(horizontalPadding: 0)

                Spacer()

                Button {
                    submit()
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

                        if isSaving {
                            ProgressView()
                                .tint(Color.brandPrimaryColor)
                        } else {
                            Text(Strings.Profile.save)
                                .foregroundStyle(Color.brandPrimaryColor)
                                .font(AppTypography.button)
                                .appShadow(AppShadow.control)
                        }
                    }
                }
                .disabled(isSaving)
                .accessibilityIdentifier("profile.edit.save")
                .padding(.bottom)
            }
            .padding(.horizontal, AppSpacing.screenHorizontal)
        }
        .padding(.bottom)
        .appScreenBackground()
        .navigationBarHidden(true)
        .sheet(
            isPresented: Binding(
                get: { errorMessage != nil },
                set: { isPresented in
                    if !isPresented { errorMessage = nil }
                }
            )
        ) {
            ActionErrorSheet(
                title: Strings.Profile.updateErrorTitle,
                description: errorMessage ?? Strings.Profile.updateErrorDescription,
                primaryButtonTitle: Strings.Common.tryAgain,
                secondaryButtonTitle: Strings.Common.back,
                onPrimaryAction: {
                    errorMessage = nil
                    submit()
                },
                onSecondaryAction: {
                    errorMessage = nil
                }
            )
            .accessibilityIdentifier("profile.edit.errorSheet")
        }
    }

    private func submit() {
        guard !isSaving else { return }
        isSaving = true
        Task {
            let result = await onSave(draft)
            isSaving = false
            switch result {
            case .success:
                dismiss()
            case let .failure(message):
                errorMessage = message
            }
        }
    }
}

#Preview {
    ProfileEditFieldView(
        title: Strings.Profile.editNameTitle,
        description: Strings.Profile.editNameDescription,
        initialValue: "Blake Lehmann",
        placeholder: Strings.Profile.editNamePlaceholder,
        onSave: { _ in .success }
    )
}
