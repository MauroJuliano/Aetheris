import AetherisDesignSystem
import SwiftUI

struct OnboardingView: View {
    let onFinish: () -> Void

    var body: some View {
        GeometryReader { proxy in
            let illustrationHeight = proxy.size.height * 0.68
            let cardHeight = (proxy.size.height * 0.43) - 55

            ZStack(alignment: .bottom) {
                illustrationSection(
                    width: proxy.size.width,
                    height: illustrationHeight
                )
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .top
                )

                bottomCard
                    .frame(height: cardHeight)
            }
        }
        .ignoresSafeArea()
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("registration.onboardingScreen")
    }
}

private extension OnboardingView {

    func illustrationSection(
        width: CGFloat,
        height: CGFloat
    ) -> some View {
        Image.designSystem("illustrationPeople")
            .resizable()
            .scaledToFill()
            .frame(
                width: width,
                height: height
            )
            .clipped()
    }

    var bottomCard: some View {
        VStack(spacing: 0) {
            VStack(spacing: AppSpacing.medium) {
                Text(Strings.Onboarding.stepOneTitle)
                    .font(AppTypography.screenTitle)
                    .bold()
                    .foregroundStyle(Color.textPrimary)
                    .multilineTextAlignment(.center)
                
                Text(Strings.Onboarding.stepOneDescription)
                    .font(AppTypography.body)
                    .foregroundStyle(Color.textSecondaryColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, AppSpacing.medium)
            }

            Spacer()

            GlowButton(title: Strings.Onboarding.stepThreeButton,
                       action: onFinish)
            .accessibilityIdentifier("registration.onboardingFinish")
            .padding(.bottom, 60)
        }
        .padding(.horizontal, AppSpacing.large)
        .padding(.top, 30)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(
            UnevenRoundedRectangle(
                topLeadingRadius: 36,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 0,
                topTrailingRadius: 36
            )
        )
        .shadow(
            color: Color.black.opacity(0.06),
            radius: 18,
            y: -4
        )
    }
}

#Preview {
    OnboardingView(onFinish: {})
}
