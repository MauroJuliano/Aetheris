import AetherisDesignSystem
import Core
import SwiftUI

struct BirthdateView: View {
    @StateObject private var viewModel: BirthdateViewModel
    @ObservedObject private var draft: RegistrationDraft
    private var onContinue: () -> Void
    
    init(viewModel: BirthdateViewModel,
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
                            get: { draft.birthdate },
                            set: { viewModel.updateBirthdate($0) }
                         ),
                         buttonTitle: viewModel.buttonName,
                         textFieldPlaceholder: viewModel.placeholder,
                         keyboardType: .numberPad,
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
        .appScreenBackground()
        .navigationBarHidden(true)
    }
}

#Preview {
    let draft = RegistrationDraft()
    BirthdateView(
        viewModel: BirthdateViewModel(service: BirthdateService(coreService: MockCoreServiceApi()),
                                      draft: draft),
        draft: draft,
        onContinue: {}
    )
}
