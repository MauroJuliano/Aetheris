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
        ZStack {
            RegisterView(title: viewModel.title,
                         textFieldValue: $viewModel.mothersNameInput,
                         buttonTitle: viewModel.buttonName,
                         textFieldPlaceholder: viewModel.placeholder,
                         onAction: {
                viewModel.submit()
            })
            .onReceive( viewModel.submissionSucceeded) {
                onContinue()
            }
            .opacity(viewModel.isLoading ? 0 : 1)
            
            RegisterInputSkeleton()
                .opacity(viewModel.isLoading ? 1 : 0)
        }
    }
}

#Preview {
    MothersNameInputView(viewModel: MothersNameInputViewModel()) {
        print("Preview")
    }
}
