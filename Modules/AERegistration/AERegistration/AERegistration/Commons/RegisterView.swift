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
                .foregroundStyle(Color.textPrimary)
                .font(AppTypography.screenTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, AppSpacing.formTop)
                .padding(.horizontal, AppSpacing.formHorizontal)
            
            Text(subTitle)
                .foregroundStyle(Color.textTertiary)
                .font(AppTypography.headline)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, AppSpacing.formHorizontal)
            
            Spacer()
            
            TextField(
                "",
                text: $textFieldValue,
                prompt: Text(textFieldPlaceholder)
                    .foregroundColor(Color.textTertiary)
                    .font(AppTypography.input)
            )
            .focused($isTextFieldFocused)
            .keyboardType(keyboardType)
            .appInputField()
            .padding(.bottom, AppSpacing.xxLarge)
            
            GlowButton(title: buttonTitle) {
                onAction()
            }
            .padding(.bottom, AppSpacing.xxLarge)
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
