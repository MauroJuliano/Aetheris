import AetherisDesignSystem
import SwiftUI

struct SINView: View {
    @StateObject private var viewModel: SINViewModel
    @State private var text = ""
    private var onContinue: () -> Void
    
    init(viewModel: SINViewModel,
         onContinue: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onContinue = onContinue
    }
    
    var body: some View {
        ZStack {
            RegisterView(
                title: viewModel.title,
                subTitle: viewModel.subtitle,
                textFieldValue: Binding(
                    get: { viewModel.sin },
                    set: { viewModel.updateSIN($0) }
                ),
                buttonTitle: viewModel.buttonName,
                textFieldPlaceholder: viewModel.placeholder,
                keyboardType: .numberPad
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
        .background(Color.backgroundColorA)
    }
}

#Preview {
    SINView(viewModel: SINViewModel(service: MockSINService())) {
        print("Preview")
    }
}
