import AetherisDesignSystem
import Core
import SwiftUI

struct MothersNameInputView: View {
    @StateObject private var viewModel: MothersNameInputViewModel
    private let onBack: () -> Void
    private var onContinue: () -> Void
    
    init(viewModel: MothersNameInputViewModel,
         onBack: @escaping () -> Void,
         onContinue: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onBack = onBack
        self.onContinue = onContinue
    }
    
    var body: some View {
        ZStack {
            RegisterView(title: viewModel.title,
                             subTitle: viewModel.subTitle,
                             screenAccessibilityIdentifier: "registration.step.motherName",
                             textFieldValue: Binding(
                                get: { viewModel.mothersName },
                                set: { viewModel.updateMothersName($0) }
                             ),
                             buttonTitle: viewModel.buttonName,
                             textFieldPlaceholder: viewModel.placeholder,
                             fieldErrorMessage: viewModel.errorMessage,
                             textFieldFormatter: RegistrationInputRules.sanitizeName,
                             onAction: {
                    viewModel.submit(onContinue: onContinue)
                })
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
        .appScreenBackground()
        .navigationBarHidden(true)
    }
}

#Preview {
    let draft = RegistrationDraft.previewFilled

    MothersNameInputView(
        viewModel: MothersNameInputViewModel(draft: draft),
        onBack: {},
        onContinue: {}
    )
}
