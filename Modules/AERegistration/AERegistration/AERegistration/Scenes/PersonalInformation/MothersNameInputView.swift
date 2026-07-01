import SwiftUI

struct MothersNameInputView: View {
    @StateObject private var viewModel: MothersNameInputViewModel
    private var onContinue: () -> Void
    
    init(viewModel: MothersNameInputViewModel,
         onContinue: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onContinue = onContinue
    }
    
    var body: some View {
        RegisterView(title: viewModel.title,
                     subTitle: viewModel.subTitle,
                     textFieldValue: $viewModel.mothersNameInput,
                     buttonTitle: viewModel.buttonName,
                     textFieldPlaceholder: viewModel.placeholder,
                     onAction: {
            viewModel.submit()
        })
        .onReceive( viewModel.submissionSucceeded) {
            onContinue()
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    MothersNameInputView(viewModel: MothersNameInputViewModel()) {
        print("Preview")
    }
}
