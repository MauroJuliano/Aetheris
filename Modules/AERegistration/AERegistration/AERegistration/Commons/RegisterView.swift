import AetherisDesignSystem
import SwiftUI

struct RegisterView: View {
    let title: String
    let subTitle: String
    @FocusState private var isTextFieldFocused: Bool
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
        .accessibilityIdentifier("registration.screen")
        .background {
            Image("login-background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
        .simultaneousGesture(
            TapGesture().onEnded {
                isTextFieldFocused = false
            }
        )
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
        } else {
            TextField(
                "",
                text: $textFieldValue,
                prompt: inputPrompt
            )
            .accessibilityIdentifier("registration.input")
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
