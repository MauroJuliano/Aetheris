import AetherisDesignSystem
import SwiftUI

struct ProfileEditFieldView: View {
    let title: String
    let description: String
    let value: String
    let placeholder: String
    let onSave: (String) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var draft: String

    init(
        title: String,
        description: String,
        value: String,
        placeholder: String,
        onSave: @escaping (String) -> Void
    ) {
        self.title = title
        self.description = description
        self.value = value
        self.placeholder = placeholder
        self.onSave = onSave
        _draft = State(initialValue: value)
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
                    onSave(draft)
                    dismiss()
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

                        Text(Strings.Profile.save)
                            .foregroundStyle(Color.brandPrimaryColor)
                            .font(AppTypography.button)
                            .appShadow(AppShadow.control)
                    }
                }
                .padding(.bottom)
            }
            .padding(.horizontal, AppSpacing.screenHorizontal)
        }
        .padding(.bottom)
        .appScreenBackground()
        .navigationBarHidden(true)
    }
}
