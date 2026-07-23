import AetherisDesignSystem
import Core
import SwiftUI

struct SINView: View {
    @StateObject private var viewModel: SINViewModel
    @ObservedObject private var draft: RegistrationDraft
    private var onContinue: () -> Void
    
    init(viewModel: SINViewModel,
         draft: RegistrationDraft,
         onContinue: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _draft = ObservedObject(wrappedValue: draft)
        self.onContinue = onContinue
    }
    
    var body: some View {
        ZStack {
            RegisterView(
                title: viewModel.title,
                subTitle: viewModel.subtitle,
                textFieldValue: Binding(
                    get: { draft.sin },
                    set: { viewModel.updateSIN($0) }
                ),
                buttonTitle: viewModel.buttonName,
                textFieldPlaceholder: viewModel.placeholder,
                keyboardType: .numberPad,
                fieldErrorMessage: viewModel.errorMessage
            ) {
                viewModel.submit()
            }
            .onReceive(viewModel.submissionSucceeded) {
                onContinue()
            }
            .opacity(viewModel.isLoading ? 0 : 1)
            
            RegisterInputSkeleton()
                .opacity(viewModel.isLoading ? 1 : 0)
        }
        .appScreenBackground()
        .navigationBarHidden(true)
    }
}

#Preview {
    let draft = RegistrationDraft()
    SINView(viewModel: SINViewModel(service: SINService(coreService: MockCoreServiceApi()), draft: draft),
            draft: draft) {}
}
