import AetherisDesignSystem
import Core
import SwiftUI

struct BirthdateView: View {
    @StateObject private var viewModel: BirthdateViewModel
    private let onBack: () -> Void
    private var onContinue: () -> Void
    
    init(viewModel: BirthdateViewModel,
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
                             screenAccessibilityIdentifier: "registration.step.birthdate",
                             textFieldValue: Binding(
                                get: { viewModel.birthdate },
                                set: { viewModel.updateBirthdate($0) }
                             ),
                             buttonTitle: viewModel.buttonName,
                             textFieldPlaceholder: viewModel.placeholder,
                             keyboardType: .numberPad,
                             fieldErrorMessage: viewModel.errorMessage,
                             textFieldFormatter: RegistrationInputRules.sanitizeBirthdate,
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

    BirthdateView(
        viewModel: BirthdateViewModel(draft: draft),
        onBack: {},
        onContinue: {}
    )
}
