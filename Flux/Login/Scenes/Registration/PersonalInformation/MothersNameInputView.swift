import SwiftUI

struct MothersNameInputView: View {
    @StateObject private var viewModel = MothersNameInputViewModel()
    var onContinue: () -> Void
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text(viewModel.title)
                        .foregroundStyle(.black)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                }
                .padding(.top, 20)
                .padding(.horizontal, 35)
                
                Spacer()
                
                HStack {
                    TextField(
                        "",
                        text: $viewModel.mothersNameInput,
                        prompt: Text(viewModel.placeholder)
                            .foregroundColor(.black.opacity(0.6))
                            .font(.body)
                    )
                    .foregroundStyle(.black)
                    .disableAutocorrection(true)
                    .keyboardType(.default)
                }
                .underlined(color: .gray.opacity(0.3))
                .padding(.horizontal, 35)
                
                GlowButton(title: viewModel.buttonName) {
                    onContinue()
                }
                .padding(.vertical, 25)
                
            }
            .opacity(viewModel.isLoading ? 0 : 1)
            
            RegisterInputSkeleton()
                .opacity(viewModel.isLoading ? 1 : 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundColorA)
    }
}

#Preview {
    MothersNameInputView {
        print("Preview")
    }
}
