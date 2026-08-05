import AetherisDesignSystem
import SwiftUI

struct ProfileFeedbackView: View {
    let onDone: () -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var feedback = ""
    private let feedbackLimit = 1_000

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

                feedbackTextEditor

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

    private var feedbackTextEditor: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: AppRadius.card, style: .continuous)
                .fill(Color.backgroundColorA)
                .overlay {
                    RoundedRectangle(cornerRadius: AppRadius.card, style: .continuous)
                        .stroke(Color.border, lineWidth: 1)
                }

            TextEditor(text: $feedback)
                .font(AppTypography.body)
                .foregroundStyle(Color.textPrimary)
                .scrollContentBackground(.hidden)
                .padding(.horizontal, AppSpacing.medium)
                .padding(.top, AppSpacing.small)
                .padding(.bottom, 40)
                .onChange(of: feedback) { _, newValue in
                    if newValue.count > feedbackLimit {
                        feedback = String(newValue.prefix(feedbackLimit))
                    }
                }

            if feedback.isEmpty {
                Text(Strings.Profile.feedbackPlaceholder)
                    .font(AppTypography.body)
                    .foregroundStyle(Color.textSecondaryColor.opacity(0.7))
                    .padding(.horizontal, AppSpacing.medium)
                    .padding(.top, AppSpacing.medium)
                    .allowsHitTesting(false)
            }

            VStack {
                Spacer()

                HStack {
                    Spacer()

                    Text("\(feedback.count)/\(feedbackLimit)")
                        .font(AppTypography.caption)
                        .foregroundStyle(Color.textSecondaryColor)
                }
                .padding(AppSpacing.medium)
            }
            .allowsHitTesting(false)
        }
        .frame(minHeight: 360)
    }
}
