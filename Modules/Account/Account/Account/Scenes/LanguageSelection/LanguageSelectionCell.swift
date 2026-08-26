import AetherisDesignSystem
import Core
import SwiftUI

struct LanguageSelectionCell: View {
    let language: AppLanguage
    let isSelected: Bool
    let isEnabled: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: AppSpacing.medium) {
                VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
                    Text(language.title)
                        .font(AppTypography.body)
                        .bold()
                        .foregroundStyle(Color.textPrimary)

                    Text(language.subtitle)
                        .font(AppTypography.cellCaption)
                        .foregroundStyle(Color.textSecondaryColor)
                }

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(Color.brandPrimaryColor)
                        .accessibilityHidden(true)
                }
            }
            .padding(AppSpacing.medium)
            .contentShape(Rectangle())
            .background(isSelected ? Color.brandPrimaryColor.opacity(0.05) : Color.clear)
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
        .accessibilityLabel(language.title)
        .accessibilityValue(isSelected ? Strings.Language.selected : language.subtitle)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}
