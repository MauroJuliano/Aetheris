import AetherisDesignSystem
import Core
import SwiftUI

struct SINView: View {
    @StateObject private var viewModel: SINViewModel
    private let onBack: () -> Void
    private var onContinue: () -> Void
    
    init(viewModel: SINViewModel,
         onBack: @escaping () -> Void,
         onContinue: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onBack = onBack
        self.onContinue = onContinue
    }
    
    var body: some View {
        ZStack {
            RegisterView(
                    title: viewModel.title,
                    subTitle: viewModel.subtitle,
                    textFieldValue: Binding(
                        get: { viewModel.sin },
                        set: { viewModel.updateSIN($0) }
                    ),
                    buttonTitle: viewModel.buttonName,
                    textFieldPlaceholder: viewModel.placeholder,
                    keyboardType: .numberPad,
                    fieldErrorMessage: viewModel.errorMessage,
                    textFieldFormatter: RegistrationInputRules.sanitizeSIN
                    ) {
                        viewModel.submit(onContinue: onContinue)
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
        .appScreenBackground()
        .navigationBarHidden(true)
    }
}

#Preview {
    let draft = RegistrationDraft.previewFilled

    SINView(
        viewModel: SINViewModel(draft: draft),
        onBack: {},
        onContinue: {}
    )
}
