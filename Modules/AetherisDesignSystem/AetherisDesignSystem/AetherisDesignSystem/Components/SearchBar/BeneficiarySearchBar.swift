import SwiftUI

public struct BeneficiarySearchBar: View {
    @Binding public var text: String
    @FocusState private var isFocused: Bool

    private let placeholder: String
    private let clearLabel: String

    public init(
        text: Binding<String>,
        placeholder: String,
        clearLabel: String
    ) {
        _text = text
        self.placeholder = placeholder
        self.clearLabel = clearLabel
    }

    public var body: some View {
        HStack(spacing: AppSpacing.small) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(Color.brandPrimaryColor)

            TextField(placeholder, text: $text)
                .font(AppTypography.body)
                .foregroundStyle(Color.textPrimary)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .focused($isFocused)

            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(Color.textTertiary)
                }
                .buttonStyle(.plain)
                .accessibilityLabel(clearLabel)
            }
        }
        .padding(.horizontal, AppSpacing.medium)
        .frame(height: 54)
        .background(Color.backgroundColorA)
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.large))
        .overlay {
            RoundedRectangle(cornerRadius: AppRadius.large)
                .stroke(
                    isFocused ? Color.brandPrimaryColor.opacity(0.45) : Color.textTertiary.opacity(0.12),
                    lineWidth: 1
                )
        }
        .animation(.easeInOut(duration: 0.15), value: isFocused)
    }

    @ViewBuilder
    public func toSkeleton(enable: Bool) -> some View {
        if enable {
            BeneficiarySearchBarSkeleton()
        } else {
            self
        }
    }
}

#Preview {
    @Previewable @State var text = "Sophie"

    BeneficiarySearchBar(
        text: $text,
        placeholder: "Search beneficiaries",
        clearLabel: "Clear search"
    )
    .padding()
    .appScreenBackground()
}
