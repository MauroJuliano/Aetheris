import AetherisDesignSystem
import SwiftUI

struct RegisterView: View {
    let title: String
    let subTitle: String
    @FocusState private var isSecureFieldFocused: Bool
    @State private var isTextFieldFocused = false
    @Binding var textFieldValue: String
    @State private var isSecureTextVisible = false
    
    var buttonTitle: String
    var textFieldPlaceholder: String
    var keyboardType: UIKeyboardType = .default
    var textContentType: UITextContentType? = nil
    var isSecureEntry: Bool = false
    var fieldErrorMessage: String? = nil
    var secureTextHiddenLabel: String = ""
    var secureTextVisibleLabel: String = ""
    var textFieldFormatter: (String) -> String = { $0 }
    
    var onAction: () -> Void = {}
    
    var body: some View {
        VStack {
            header
            subtitle
            
            Spacer()
            
            inputSection
            .padding(.bottom, AppSpacing.xxLarge)
            
            GlowButton(title: buttonTitle) {
                onAction()
            }
            .accessibilityIdentifier("registration.continue")
            .padding(.bottom, AppSpacing.xxLarge)
        }
        .background {
            Image("login-background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .contentShape(Rectangle())
                .onTapGesture {
                    isTextFieldFocused = false
                    isSecureFieldFocused = false
                }
        }
    }

    private var header: some View {
        Text(title)
            .foregroundStyle(Color.textPrimary)
            .font(AppTypography.screenTitle)
            .fontWeight(.bold)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, AppSpacing.formTop)
            .padding(.horizontal, AppSpacing.formHorizontal)
    }

    private var subtitle: some View {
        Text(subTitle)
            .foregroundStyle(Color.textTertiary)
            .font(AppTypography.headline)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, AppSpacing.formHorizontal)
    }

    private var inputSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
            fieldError
            inputField
        }
    }

    @ViewBuilder
    private var fieldError: some View {
        if let fieldErrorMessage {
            Text(fieldErrorMessage)
                .font(AppTypography.caption)
                .foregroundStyle(Color.error)
                .padding(.horizontal, AppSpacing.formHorizontal)
        }
    }

    private var inputField: some View {
        HStack(spacing: AppSpacing.small) {
            inputControl

            if isSecureEntry {
                visibilityToggle
            }
        }
        .keyboardType(keyboardType)
        .appInputField(underlineColor: fieldErrorMessage == nil ? Color.border : Color.error)
    }

    @ViewBuilder
    private var inputControl: some View {
        if isSecureEntry && !isSecureTextVisible {
            SecureField(
                "",
                text: $textFieldValue,
                prompt: inputPrompt
            )
            .accessibilityIdentifier("registration.input")
            .focused($isSecureFieldFocused)
        } else {
            RegistrationTextField(
                text: $textFieldValue,
                placeholder: textFieldPlaceholder,
                formatter: textFieldFormatter,
                keyboardType: keyboardType,
                isFocused: Binding(
                    get: { isTextFieldFocused },
                    set: { isTextFieldFocused = $0 }
                ),
                accessibilityIdentifier: "registration.input"
            )
            .frame(height: 52)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private var inputPrompt: Text {
        Text(textFieldPlaceholder)
            .foregroundColor(Color.textTertiary)
            .font(AppTypography.input)
    }

    private var visibilityToggle: some View {
        Button {
            isSecureTextVisible.toggle()
        } label: {
            Image(systemName: isSecureTextVisible ? "eye.slash" : "eye")
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(Color.textTertiary)
        }
        .accessibilityLabel(isSecureTextVisible ? secureTextVisibleLabel : secureTextHiddenLabel)
    }
}

private struct RegistrationTextField: UIViewRepresentable {
    @Binding var text: String
    let placeholder: String
    let formatter: (String) -> String
    let keyboardType: UIKeyboardType
    @Binding var isFocused: Bool
    let accessibilityIdentifier: String

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        textField.borderStyle = .none
        textField.backgroundColor = .clear
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .center
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textField.textColor = UIColor(Color.textPrimary)
        textField.font = .preferredFont(forTextStyle: .body)
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: UIColor(Color.textTertiary),
                .font: UIFont.preferredFont(forTextStyle: .body)
            ]
        )
        textField.keyboardType = keyboardType
        textField.accessibilityIdentifier = accessibilityIdentifier
        textField.addTarget(
            context.coordinator,
            action: #selector(Coordinator.editingChanged(_:)),
            for: .editingChanged
        )
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.keyboardType = keyboardType

        if uiView.text != text {
            uiView.text = text
        }

        if isFocused, !uiView.isFirstResponder {
            uiView.becomeFirstResponder()
        } else if !isFocused, uiView.isFirstResponder {
            uiView.resignFirstResponder()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(
            text: $text,
            formatter: formatter,
            isFocused: $isFocused
        )
    }

    final class Coordinator: NSObject, UITextFieldDelegate {
        private let text: Binding<String>
        private let formatter: (String) -> String
        private let isFocused: Binding<Bool>

        init(
            text: Binding<String>,
            formatter: @escaping (String) -> String,
            isFocused: Binding<Bool>
        ) {
            self.text = text
            self.formatter = formatter
            self.isFocused = isFocused
        }

        func textFieldDidBeginEditing(_ textField: UITextField) {
            isFocused.wrappedValue = true
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            isFocused.wrappedValue = false
        }

        func textField(
            _ textField: UITextField,
            shouldChangeCharactersIn range: NSRange,
            replacementString string: String
        ) -> Bool {
            let currentText = textField.text ?? ""

            guard let textRange = Range(range, in: currentText) else {
                return false
            }

            let updatedText = currentText.replacingCharacters(in: textRange, with: string)
            let formattedText = formatter(updatedText)

            textField.text = formattedText
            text.wrappedValue = formattedText

            return false
        }

        @objc
        func editingChanged(_ textField: UITextField) {
            let formattedText = formatter(textField.text ?? "")
            if textField.text != formattedText {
                textField.text = formattedText
            }
            if text.wrappedValue != formattedText {
                text.wrappedValue = formattedText
            }
        }
    }
}

#Preview {
    @Previewable @State var value = "Melissa"

    RegisterView(
        title: "Create your account",
        subTitle: "Tell us how we should call you.",
        textFieldValue: $value,
        buttonTitle: "Continue",
        textFieldPlaceholder: "Full name"
    )
}
