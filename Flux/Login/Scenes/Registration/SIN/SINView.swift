import SwiftUI

struct SocialInsuranceNumberEntryView: View {
    @StateObject private var viewModel = SINViewModel(service: MockSINService())
    @State private var text = ""
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
                        text: $text,
                        prompt: Text(viewModel.placeholder)
                            .foregroundColor(.black.opacity(0.6))
                            .font(.body)
                    )
                    .onChange(of: text) { newValue in
                        viewModel.updateSIN(newValue)
                        text = viewModel.formattedSIN()
                    }
                    .foregroundStyle(.black)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .keyboardType(.numberPad)
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
    SocialInsuranceNumberEntryView {
        print("Preview")
    }
}
