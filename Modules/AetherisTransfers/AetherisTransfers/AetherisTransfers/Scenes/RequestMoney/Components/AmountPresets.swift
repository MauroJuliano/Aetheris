import AetherisDesignSystem
import SwiftUI

struct AmountPresets: View {
    let amountText: String
    let presets: [RequestMoneyAmountPresetModel]
    let onPresetTap: (Decimal) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: AppSpacing.small) {
                ForEach(presets) { preset in
                    presetButton(preset)
                }
            }
        }
    }

    private func presetButton(_ preset: RequestMoneyAmountPresetModel) -> some View {
        let isSelected = CurrencyInputFormatter.decimal(from: amountText) == preset.value

        return Button {
            onPresetTap(preset.value)
        } label: {
            Text(preset.title)
                .font(AppTypography.cellCaption)
                .bold()
                .foregroundStyle(isSelected ? Color.white : Color.brandPrimaryColor)
                .padding(.horizontal, AppSpacing.medium)
                .frame(height: 42)
                .background {
                    if isSelected {
                        LinearGradient(
                            colors: [
                                Color.brandPrimaryColor,
                                Color.brandSecondaryColor
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    } else {
                        Color.clear
                    }
                }
                .overlay {
                    Capsule()
                        .stroke(
                            isSelected
                                ? Color.clear
                                : Color.brandPrimaryColor.opacity(0.25)
                        )
                }
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}
