import AetherisDesignSystem
import SwiftUI

struct ProfileLegalView: View {
    let onDone: () -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: AppSpacing.large) {
                NavBar(
                    hasNotifications: false,
                    hasBackButton: true,
                    model: .init(firstText: Strings.Profile.privacyPolicy, hasInitialSpace: false),
                    onBack: { dismiss() }
                )

                VStack(alignment: .leading, spacing: AppSpacing.large) {
                    Text(Strings.Profile.privacyPolicy)
                        .font(AppTypography.headline)
                        .foregroundStyle(Color.textPrimary)

                    Text(Strings.Profile.legalDescription)
                        .font(AppTypography.subheadline)
                        .foregroundStyle(Color.textSecondaryColor)
                        .lineSpacing(4)

                    Spacer(minLength: AppSpacing.xxLarge)

                    Button {
                        onDone()
                        dismiss()
                    } label: {
                        Text(Strings.Profile.done)
                            .foregroundStyle(Color.brandPrimaryColor)
                            .font(AppTypography.button)
                    }
                    .padding(.bottom, AppSpacing.bottomBarClearance)
                }
                .padding(.horizontal, AppSpacing.screenHorizontal)
            }
        }
        .padding(.bottom, AppSpacing.formTop)
        .appScreenBackground()
        .navigationBarHidden(true)
    }
}

#Preview {
    ProfileLegalView(onDone: {})
}
