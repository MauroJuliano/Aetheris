import AetherisDesignSystem
import SwiftUI

struct BeneficiarySearchBar: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool

    init(text: Binding<String>) {
        _text = text
    }

    var body: some View {
        HStack(spacing: AppSpacing.small) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(Color.brandPrimaryColor)

            TextField(
                Strings.BeneficiaryList.searchPlaceholder,
                text: $text
            )
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
                .accessibilityLabel(Strings.BeneficiaryList.clearSearch)
            }
        }
        .padding(.horizontal, AppSpacing.medium)
        .frame(height: 54)
        .background(Color.backgroundColorA)
        .clipShape(
            RoundedRectangle(
                cornerRadius: AppRadius.large
            )
        )
        .overlay {
            RoundedRectangle(
                cornerRadius: AppRadius.large
            )
            .stroke(
                isFocused
                    ? Color.brandPrimaryColor.opacity(0.45)
                    : Color.textTertiary.opacity(0.12),
                lineWidth: 1
            )
        }
        .animation(
            .easeInOut(duration: 0.15),
            value: isFocused
        )
    }
}

#Preview {
    @Previewable @State var text = "Adele"

    BeneficiarySearchBar(text: $text)
        .padding()
        .appScreenBackground()
}
