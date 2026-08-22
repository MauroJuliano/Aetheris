import AetherisDesignSystem
import Core
import SwiftUI

struct UserNameView: View {
    @StateObject private var viewModel: UserNameViewModel
    private let onBack: () -> Void
    private let onContinue: () -> Void
    
    init(viewModel: UserNameViewModel,
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
                             screenAccessibilityIdentifier: "registration.step.fullName",
                             textFieldValue: Binding(
                                get: { viewModel.userName },
                                set: { viewModel.updateUserName($0) }
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

    UserNameView(
        viewModel: UserNameViewModel(draft: draft),
        onBack: {},
        onContinue: {}
    )
}
