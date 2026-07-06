import AetherisDesignSystem
import SwiftUI

struct BirthdateView: View {
    @StateObject private var viewModel: BirthdateViewModel
    private var onContinue: () -> Void
    
    init(viewModel: BirthdateViewModel,
         onContinue: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onContinue = onContinue
    }
    
    var body: some View {
        ZStack {
            RegisterView(title: viewModel.title,
                         subTitle: viewModel.subTitle,
                         textFieldValue: $viewModel.birthdate,
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
        .appScreenBackground()
        .navigationBarHidden(true)
    }
}

#Preview {
    BirthdateView(
        viewModel: BirthdateViewModel(service: MockBirthdateService()),
        onContinue: {
            print("preview")
        }
    )
}
