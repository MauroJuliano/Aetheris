import AetherisDesignSystem
import SwiftUI

struct ProfileFeedbackView: View {
    let onDone: () -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var feedback = ""

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.large) {
            NavBar(
                hasNotifications: false,
                hasBackButton: true,
                model: .init(firstText: Strings.Profile.feedbackTitle, hasInitialSpace: false),
                onBack: { dismiss() }
            )

            VStack(alignment: .leading, spacing: AppSpacing.large) {
                Text(Strings.Profile.feedbackDescription)
                    .font(AppTypography.subheadline)
                    .foregroundStyle(Color.textSecondaryColor)

                TextEditor(text: $feedback)
                    .frame(minHeight: 180)
                    .padding(AppSpacing.medium)
                    .background(
                        RoundedRectangle(cornerRadius: AppRadius.card, style: .continuous)
                            .fill(Color.backgroundColorA)
                            .overlay(
                                RoundedRectangle(cornerRadius: AppRadius.card, style: .continuous)
                                    .stroke(Color.border, lineWidth: 1)
                            )
                    )

                Spacer()

                Button {
                    onDone()
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

                        Text(Strings.Profile.sendFeedback)
                            .foregroundStyle(Color.brandPrimaryColor)
                            .font(AppTypography.button)
                            .appShadow(AppShadow.control)
                    }
                }
                .padding(.bottom, AppSpacing.medium)
            }
            .padding(.horizontal, AppSpacing.screenHorizontal)
        }
        .padding(.bottom, AppSpacing.formTop)
        .appScreenBackground()
        .navigationBarHidden(true)
    }
}
