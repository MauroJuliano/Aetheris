import SwiftUI

struct BirthdateView: View {
    @StateObject private var viewModel = BirthdateViewModel(service: MockBirthdateService())
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
                        text: $viewModel.birthdate,
                        prompt: Text(viewModel.placeholder)
                            .foregroundColor(.black.opacity(0.6))
                            .font(.body)
                    )
                    .foregroundStyle(.black)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                }
                .underlined(color: .gray.opacity(0.3))
                .padding(.horizontal, 35)
                
                GlowButton(title: viewModel.buttonName ) {
                    viewModel.submit()
                }
                .onChange(of: viewModel.submissionSuccess) { success in
                    if success == true {
                        onContinue()
                    }
                }
                .padding(.vertical, 25)
                
            }
            .opacity(viewModel.isLoading ? 0 : 1)
            
            RegisterInputSkeleton()
                .opacity(viewModel.isLoading ? 1 : 0)
        }
        .background(Color.backgroundColorA)
    }
}

#Preview {
    BirthdateView {
        print("preview")
    }
}
