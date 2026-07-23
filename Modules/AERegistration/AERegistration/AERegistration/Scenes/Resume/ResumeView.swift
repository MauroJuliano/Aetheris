import AetherisDesignSystem
import SwiftUI

struct ResumeView: View {
    @StateObject private var viewModel: ResumeViewModel
    private var onContinue: () -> Void
    
    init(viewModel: ResumeViewModel,
         onContinue: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onContinue = onContinue
    }
    
    var body: some View {
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
                onContinue()
            }
            .padding(.vertical, AppSpacing.medium)
        }
        .background {
            Image("login-background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    let draft = RegistrationDraft()
    draft.sin = "000.000.000"
    draft.mothersName = "Jane Doe"
    draft.userName = "Melissa"
    draft.birthdate = "10/10/1999"

    return ResumeView(
        viewModel: ResumeViewModel(draft: draft)
    ) {}
}
