import Core
import SwiftUI

struct UserNameView: View {
    @StateObject private var viewModel: UserNameViewModel
    @ObservedObject private var draft: RegistrationDraft
    private let onContinue: () -> Void
    
    init(viewModel: UserNameViewModel,
         draft: RegistrationDraft,
         onContinue: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _draft = ObservedObject(wrappedValue: draft)
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
                viewModel.submit()
            })
            .onReceive(viewModel.submissionSucceeded) {
                onContinue()
            }
            .opacity(viewModel.isLoading ? 0 : 1)
            
            RegisterInputSkeleton()
                .opacity(viewModel.isLoading ? 1 : 0)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    let draft = RegistrationDraft()
    UserNameView(viewModel: UserNameViewModel(service: UserNameService(coreService: MockCoreServiceApi()), draft: draft),
                 draft: draft) {}
}
