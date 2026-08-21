import AetherisDesignSystem
import Core
import SwiftUI

struct EmailView: View {
    @StateObject private var viewModel: EmailViewModel
    private let onBack: () -> Void
    private let onContinue: () -> Void

    init(
        viewModel: EmailViewModel,
        onBack: @escaping () -> Void,
        onContinue: @escaping () -> Void
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onBack = onBack
        self.onContinue = onContinue
    }

    var body: some View {
        ZStack {
            RegisterView(
                title: viewModel.title,
                subTitle: viewModel.subTitle,
                textFieldValue: Binding(
                    get: { viewModel.email },
                    set: { viewModel.updateEmail($0) }
                ),
                buttonTitle: viewModel.buttonName,
                textFieldPlaceholder: viewModel.placeholder,
                keyboardType: .emailAddress,
                textContentType: .emailAddress,
                fieldErrorMessage: viewModel.errorMessage,
                onAction: {
                    viewModel.submit(onContinue: onContinue)
                }
            )
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

    EmailView(
        viewModel: EmailViewModel(draft: draft),
        onBack: {},
        onContinue: {}
    )
}
