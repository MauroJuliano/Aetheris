import AetherisDesignSystem
import SwiftUI

struct RegisterView: View {
    let title: String
    let subTitle: String
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
    var isLoading = false
    
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
            .toSkeleton(enable: isLoading)
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
                }
        }
    }

    @ViewBuilder
    private var header: some View {
        if isLoading {
            SkeletonBlock(width: 260, height: 40, radius: AppRadius.large)
                .padding(.top, AppSpacing.formTop)
                .padding(.horizontal, AppSpacing.formHorizontal)
        } else {
            Text(title)
            .foregroundStyle(Color.textPrimary)
            .font(AppTypography.screenTitle)
            .fontWeight(.bold)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, AppSpacing.formTop)
            .padding(.horizontal, AppSpacing.formHorizontal)
        }
    }

    @ViewBuilder
    private var subtitle: some View {
        if isLoading {
            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                SkeletonBlock(width: 320, height: 18, radius: 9)
                SkeletonBlock(width: 230, height: 18, radius: 9)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, AppSpacing.formHorizontal)
        } else {
            Text(subTitle)
            .foregroundStyle(Color.textTertiary)
            .font(AppTypography.headline)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, AppSpacing.formHorizontal)
        }
    }

    private var inputSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
            fieldError
            inputField
        }
        .redacted(reason: isLoading ? .placeholder : [])
        .allowsHitTesting(!isLoading)
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

    private var inputControl: some View {
        RegistrationTextField(
            text: $textFieldValue,
            placeholder: textFieldPlaceholder,
            formatter: textFieldFormatter,
            keyboardType: keyboardType,
            textContentType: textContentType,
            isSecureTextEntry: isSecureEntry && !isSecureTextVisible,
            isFocused: Binding(
                get: { isTextFieldFocused },
                set: { isTextFieldFocused = $0 }
            ),
            accessibilityIdentifier: "registration.input"
        )
        .frame(height: 52)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var visibilityToggle: some View {
        Button {
            isSecureTextVisible.toggle()
            isTextFieldFocused = true
        } label: {
            Image(systemName: isSecureTextVisible ? "eye.slash" : "eye")
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(Color.textTertiary)
                .frame(width: 44, height: 44)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(isSecureTextVisible ? secureTextVisibleLabel : secureTextHiddenLabel)
    }
}

private struct RegistrationTextField: UIViewRepresentable {
    @Binding var text: String
    let placeholder: String
    let formatter: (String) -> String
    let keyboardType: UIKeyboardType
    let textContentType: UITextContentType?
    let isSecureTextEntry: Bool
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
        textField.textContentType = textContentType
        textField.isSecureTextEntry = isSecureTextEntry
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
        uiView.textContentType = textContentType
        uiView.isSecureTextEntry = isSecureTextEntry

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
