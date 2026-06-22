import SwiftUI

struct UserNameView: View {
    @StateObject private var viewModel: UserNameViewModel
    private let onContinue: () -> Void
    
    init(viewModel: UserNameViewModel = UserNameViewModel(service: mockUserNameService()),
         onContinue: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onContinue = onContinue
    }
    var body: some View {
        ZStack {
            RegisterView(title: viewModel.title,
                         textFieldValue: $viewModel.userName,
                         buttonTitle: viewModel.buttonName,
                         textFieldPlaceholder: viewModel.placeholder,
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
    }
}

#Preview {
    UserNameView {
        print("Preview")
    }
}
