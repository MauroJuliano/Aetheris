import Core
import AetherisDesignSystem
import SwiftUI

struct InsuranceOnboarding: View {
    @StateObject private var viewModel: InsuranceOnboardingViewModel

    init(viewModel: InsuranceOnboardingViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: AppSpacing.large) {
                Image("melissa")
                    .resizable()
                    .frame(height: 400)
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack(spacing: AppSpacing.large) {
                    Text(Strings.InsuranceOnboarding.subtitle)
                        .font(AppTypography.onboardingBody)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.textPrimary)
                        .multilineTextAlignment(.leading)
                        .frame(maxHeight: .infinity, alignment: .leading)
                        .padding(.top)

                    Text(Strings.InsuranceOnboarding.benefits)
                        .font(AppTypography.onboardingBody)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.textPrimary)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)

                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .padding(.vertical)
                    } else {
                        VStack(spacing: 0) {
                            ForEach(viewModel.benefits) { model in
                                BenefitsChartView(image: model.image, text: model.text)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.horizontal)

                Button {
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: AppRadius.large)
                            .fill(Color.accentColorBrown)
                            .appShadow(AppShadow.card)
                            .overlay(
                                RoundedRectangle(cornerRadius: AppRadius.pill)
                                    .stroke(Color.border, style: .init(lineWidth: 1))
                            )
                            .frame(width: 300, height: 50)

                        Text(Strings.InsuranceOnboarding.`continue`)
                            .foregroundStyle(.white)
                            .font(AppTypography.button)
                    }
                    .padding(AppSpacing.medium)
                }

                Button {
                } label: {
                    Text(Strings.InsuranceOnboarding.moreOptions)
                        .font(AppTypography.subheadline)
                        .foregroundStyle(Color.textPrimary)
                }
            }
        }
        .padding(.horizontal, AppSpacing.screenHorizontal)
        .appScreenBackground()
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .task { await viewModel.load() }
    }
}

private struct BenefitsChartView: View {
    let image: String
    let text: String

    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: image)
                .resizable()
                .foregroundStyle(Color.textPrimary)
                .frame(width: 20, height: 20)
                .padding(.trailing)

            Text(text)
                .multilineTextAlignment(.leading)
                .foregroundStyle(Color.textPrimary)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical)

        Divider()
    }
}
