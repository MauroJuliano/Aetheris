import AetherisDesignSystem
import Core
import SwiftUI

struct ResumeView: View {
    @StateObject private var viewModel: ResumeViewModel

    private let onBack: () -> Void
    private let onContinue: () -> Void
    private let onEditTap: (ResumeListModel.Kind) -> Void

    init(
        viewModel: ResumeViewModel,
        onBack: @escaping () -> Void,
        onContinue: @escaping () -> Void,
        onEditTap: @escaping (ResumeListModel.Kind) -> Void = { _ in }
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onBack = onBack
        self.onContinue = onContinue
        self.onEditTap = onEditTap
    }

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                headerSection

                resumeCard
                    .padding(.top, AppSpacing.xLarge)

                securitySection
                    .padding(.top, AppSpacing.large)
            }
            .padding(.horizontal, AppSpacing.formHorizontal)

            Spacer(minLength: AppSpacing.large)

            continueButton
        }
        .padding(.bottom, AppSpacing.large)
        .safeAreaInset(edge: .top, spacing: 0) {
            NavBar(
                hasNotifications: false,
                hasBackButton: true,
                model: .init(hasInitialSpace: false),
                onBack: onBack
            )
            .padding(.top, AppSpacing.medium)
        }
        .background {
            Image("login-background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
        .navigationBarHidden(true)
        .accessibilityIdentifier("registration.resumeScreen")
        .sheet(isPresented: submissionErrorBinding) {
            submissionErrorSheet
        }
    }
}

private extension ResumeView {
    var headerSection: some View {
        VStack(
            alignment: .leading,
            spacing: AppSpacing.small
        ) {
            Text(Strings.Resume.title)
                .font(AppTypography.screenTitle)
                .foregroundStyle(Color.textPrimary)
                .bold()

            Text(Strings.Resume.subtitle)
                .font(AppTypography.body)
                .foregroundStyle(Color.textSecondaryColor)
                .fixedSize(
                    horizontal: false,
                    vertical: true
                )
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .padding(.top, AppSpacing.medium)
    }

    var resumeCard: some View {
        VStack(spacing: 0) {
            ForEach(
                Array(viewModel.resumeList.enumerated()),
                id: \.offset
            ) { index, model in
                ResumeListCell(
                    model: model,
                    hasDivider: index != viewModel.resumeList.count - 1
                ) { selectedModel in
                    onEditTap(selectedModel.kind)
                }
            }
        }
        .padding(.vertical, AppSpacing.small)
        .appCardSurface(
            radius: AppRadius.large,
            stroke: Color.border,
            shadow: AppShadow.card
        )
    }

    var securitySection: some View {
        HStack(spacing: AppSpacing.medium) {
            Circle()
                .fill(
                    Color.brandPrimaryColor.opacity(0.10)
                )
                .frame(width: 48, height: 48)
                .overlay {
                    Image(systemName: "checkmark.shield")
                        .font(
                            .system(
                                size: 20,
                                weight: .medium
                            )
                        )
                        .foregroundStyle(
                            Color.brandPrimaryColor
                        )
                }

            Text(Strings.Resume.securityNote)
                .font(AppTypography.subheadline)
                .foregroundStyle(Color.textSecondaryColor)
                .fixedSize(
                    horizontal: false,
                    vertical: true
                )

            Spacer(minLength: 0)
        }
        .padding(AppSpacing.medium)
        .frame(maxWidth: .infinity)
        .background(
            Color.brandPrimaryColor.opacity(0.045)
        )
        .clipShape(
            RoundedRectangle(
                cornerRadius: AppRadius.large,
                style: .continuous
            )
        )
    }

    var continueButton: some View {
        GlowButton(
            title: Strings.Resume.continueButton
        ) {
            submit()
        }
        .disabled(viewModel.isLoading)
        .accessibilityIdentifier(
            "registration.resumeContinue"
        )
    }

    var submissionErrorSheet: some View {
        ActionErrorSheet(
            title: Strings.SubmissionError.title,
            description: viewModel.submissionErrorDescription,
            primaryButtonTitle:
                Strings.SubmissionError.tryAgain,
            secondaryButtonTitle:
                Strings.SubmissionError.cancel,
            onPrimaryAction: {
                viewModel.submissionError = nil
                submit()
            },
            onSecondaryAction: {
                viewModel.submissionError = nil
            }
        )
    }

    func submit() {
        Task {
            if await viewModel.submit() {
                onContinue()
            }
        }
    }
}

private extension ResumeView {

    var submissionErrorBinding: Binding<Bool> {
        Binding(
            get: {
                viewModel.submissionError != nil
            },
            set: { isPresented in
                if !isPresented {
                    viewModel.submissionError = nil
                }
            }
        )
    }
}

#Preview {
    let draft = RegistrationDraft.previewFilled

    ResumeView(
        viewModel: ResumeViewModel(
            service: RegistrationService(
                coreService: DemoCoreService(delay: 0)
            ),
            draft: draft
        ),
        onBack: {},
        onContinue: {}
    )
}
