import AetherisDesignSystem
import SwiftUI

struct RegisterView: View {
    @State var title: String
    @Binding var textFieldValue: String
    
    var buttonTitle: String
    var textFieldPlaceholder: String
    var keyboardType: UIKeyboardType = .default
    var textContentType: UITextContentType? = nil
    
    var onAction: () -> Void = {}
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
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
                    text: $textFieldValue,
                    prompt: Text(textFieldPlaceholder)
                        .foregroundColor(.black.opacity(0.6))
                        .font(.body)
                )
                .foregroundStyle(.black)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .keyboardType(keyboardType)
            }
            .underlined(color: .gray.opacity(0.3))
            .padding(.horizontal, 35)
            
            GlowButton(title: buttonTitle) {
                onAction()
            }
            .padding(.vertical, 25)
            
        }
        .background(Color.backgroundColorA)
    }
}

#Preview {
    RegisterView(title: "Full name",
                 textFieldValue: .constant("Texto"),
                 buttonTitle: "Continue",
                 textFieldPlaceholder: "Insert your name")
}
