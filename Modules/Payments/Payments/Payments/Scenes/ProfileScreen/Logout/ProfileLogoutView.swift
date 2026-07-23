import AetherisDesignSystem
import SwiftUI

struct ProfileLogoutView: View {
    let onDone: () -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.large) {
            NavBar(
                hasNotifications: false,
                hasBackButton: true,
                model: .init(firstText: Strings.Profile.logout, hasInitialSpace: false),
                onBack: { dismiss() }
            )

            VStack(alignment: .leading, spacing: AppSpacing.large) {
                Text(Strings.Profile.logoutDescription)
                    .font(AppTypography.subheadline)
                    .foregroundStyle(Color.textSecondaryColor)

                Spacer()

                Button {
                    onDone()
                    dismiss()
                } label: {
                    Text(Strings.Profile.confirmLogout)
                        .foregroundStyle(Color.white)
                        .font(AppTypography.button)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.red)
                        .clipShape(RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous))
                }
                .padding(.bottom, AppSpacing.medium)
            }
            .padding(.horizontal, AppSpacing.screenHorizontal)
        }
        .padding(.bottom)
        .appScreenBackground()
        .navigationBarHidden(true)
    }
}
