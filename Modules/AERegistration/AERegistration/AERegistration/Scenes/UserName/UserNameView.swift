import AetherisDesignSystem
import Core
import SwiftUI

struct UserNameView: View {
    @StateObject private var viewModel: UserNameViewModel
    @ObservedObject private var draft: RegistrationDraft
    private let onBack: () -> Void
    private let onContinue: () -> Void
    
    init(viewModel: UserNameViewModel,
         draft: RegistrationDraft,
         onBack: @escaping () -> Void,
         onContinue: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _draft = ObservedObject(wrappedValue: draft)
        self.onBack = onBack
        self.onContinue = onContinue
    }
    var body: some View {
        ZStack {
            RegisterView(title: viewModel.title,
                             subTitle: viewModel.subTitle,
                             textFieldValue: Binding(
                                get: { draft.userName },
                                set: { viewModel.updateUserName($0) }
                             ),
                             buttonTitle: viewModel.buttonName,
                             textFieldPlaceholder: viewModel.placeholder,
                             fieldErrorMessage: viewModel.errorMessage,
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
        draft: draft,
        onBack: {},
        onContinue: {}
    )
}
