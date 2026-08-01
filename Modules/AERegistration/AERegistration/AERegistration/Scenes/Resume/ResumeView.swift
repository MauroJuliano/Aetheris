import AetherisDesignSystem
import SwiftUI

struct ResumeView: View {
    @StateObject private var viewModel: ResumeViewModel
    private let onBack: () -> Void
    private var onContinue: () -> Void
    
    init(viewModel: ResumeViewModel,
         onBack: @escaping () -> Void,
         onContinue: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onBack = onBack
        self.onContinue = onContinue
    }
    
    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .leading) {
                    Text(Strings.Resume.title)
                        .font(AppTypography.screenTitle)
                        .foregroundStyle(Color.textPrimary)
                        .bold()
                    
                    Text(Strings.Resume.subtitle)
                        .foregroundStyle(Color.textSecondaryColor)
                }
                .padding(AppSpacing.medium)
                
                Spacer()
                
                VStack {
                    ForEach(viewModel.resumeList.indices, id: \.self) { index in
                        let model = viewModel.resumeList[index]
                        ResumeListCell(model: model,
                                       hasDivider: index != viewModel.resumeList.count - 1
                        ) { selectedModel in
                            _ = selectedModel
                        }
                    }
                }
                .padding(AppSpacing.medium)
                .appCardSurface(
                    radius: AppRadius.large,
                    stroke: Color.border,
                    shadow: AppShadow.card
                )
                .padding(.horizontal, AppSpacing.screenHorizontal)
                
                HStack {
                    Circle()
                        .fill(Color.brandPrimaryColor.opacity(0.12))
                        .frame(width: 46, height: 46)
                        .overlay {
                            Image(systemName: "checkmark.shield")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundStyle(Color.brandPrimaryColor)
                        }
                    
                    Text(Strings.Resume.securityNote)
                        .font(AppTypography.subheadline)
                        .foregroundStyle(Color.textSecondaryColor)
                }
                .padding(AppSpacing.medium)
                
                GlowButton(title: Strings.Resume.continueButton) {
                    Task {
                        if await viewModel.submit() {
                            onContinue()
                        }
                    }
                }
                .disabled(viewModel.isLoading)
                .padding(.vertical, AppSpacing.medium)
            }
        }
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
        .sheet(isPresented: submissionErrorBinding) {
            ActionErrorSheet(
                title: Strings.SubmissionError.title,
                description: viewModel.submissionErrorDescription,
                primaryButtonTitle: Strings.SubmissionError.tryAgain,
                secondaryButtonTitle: Strings.SubmissionError.cancel,
                onPrimaryAction: {
                    viewModel.submissionError = nil
                    Task {
                        if await viewModel.submit() {
                            onContinue()
                        }
                    }
                },
                onSecondaryAction: {
                    viewModel.submissionError = nil
                }
            )
        }
    }

    private var submissionErrorBinding: Binding<Bool> {
        Binding(
            get: { viewModel.submissionError != nil },
            set: { isPresented in
                if !isPresented {
                    viewModel.submissionError = nil
                }
            }
        )
    }
}
