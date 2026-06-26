import AetherisDesignSystem
import SwiftUI

struct RegisterView: View {
    let title: String
    let subTitle: String
    @FocusState private var isTextFieldFocused: Bool
    @Binding var textFieldValue: String
    
    var buttonTitle: String
    var textFieldPlaceholder: String
    var keyboardType: UIKeyboardType = .default
    var textContentType: UITextContentType? = nil
    
    var onAction: () -> Void = {}
    
    var body: some View {
        VStack {
            Text(title)
                .foregroundStyle(.black)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 60)
                .padding(.horizontal, 35)
            
            Text(subTitle)
                .foregroundStyle(Color.textTertiary)
                .font(.headline)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 35)
            
            Spacer()
            
            TextField(
                "",
                text: $textFieldValue,
                prompt: Text(textFieldPlaceholder)
                    .foregroundColor(.gray.opacity(0.6))
                    .font(.body)
            )
            .focused($isTextFieldFocused)
            .foregroundStyle(.black)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .keyboardType(keyboardType)
            .underlined(color: .gray.opacity(0.3))
            .padding(.horizontal, 35)
            .padding(.bottom, 30)
            
            GlowButton(title: buttonTitle) {
                onAction()
            }
            .padding(.bottom, 30)
        }
        .background {
            Image("login-background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
        .onTapGesture {
            isTextFieldFocused = false
        }
    }
}

#Preview {
    RegisterView(title: "Full name",
                 subTitle: "let title: String",
                 textFieldValue: .constant("Texto"),
                 buttonTitle: "Continue",
                 textFieldPlaceholder: "Insert your name")
}
