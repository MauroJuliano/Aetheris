import Core
import SwiftUI

struct MothersNameInputView: View {
    @StateObject private var viewModel: MothersNameInputViewModel
    @ObservedObject private var draft: RegistrationDraft
    private var onContinue: () -> Void
    
    init(viewModel: MothersNameInputViewModel,
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
                            get: { draft.mothersName },
                            set: { viewModel.updateMothersName($0) }
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
    MothersNameInputView(viewModel: MothersNameInputViewModel(service: MothersNameInputService(coreService: MockCoreServiceApi()),
                                                             draft: draft),
                         draft: draft) {}
}
