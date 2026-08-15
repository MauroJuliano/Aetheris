import AetherisDesignSystem
import SwiftUI

struct SharedMoneyRequestCard: View {
    let presets: [RequestMoneyAmountPresetModel]

    @Binding var amountText: String
    @Binding var reason: String

    let focusedField: FocusState<RequestMoneyField?>.Binding
    let onPresetTap: (Decimal) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.large) {
            amountSection

            AmountPresets(
                amountText: amountText,
                presets: presets,
                onPresetTap: onPresetTap
            )

            reasonSection

            Label(Strings.RequestMoney.shareDescription, systemImage: "link")
                .font(AppTypography.cellCaption)
                .foregroundStyle(Color.textSecondaryColor)
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }

    private var amountSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text(Strings.RequestMoney.shareAmountTitle)
                .font(AppTypography.body)
                .foregroundStyle(Color.textSecondaryColor)

            TextField("R$ 0,00", text: $amountText)
                .font(.system(size: 38, weight: .semibold))
                .foregroundStyle(Color.textPrimary)
                .keyboardType(.numberPad)
                .focused(focusedField, equals: .amount)
                .onChange(of: amountText) { _, newValue in
                    amountText = CurrencyInputFormatter.format(newValue)
                }
        }
    }

    private var reasonSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
            Text(Strings.RequestMoney.reasonTitle)
                .font(AppTypography.body)
                .foregroundStyle(Color.textSecondaryColor)

            TextField(
                Strings.RequestMoney.reasonPlaceholder,
                text: $reason,
                axis: .vertical
            )
            .font(AppTypography.body)
            .foregroundStyle(Color.textPrimary)
            .lineLimit(1...3)
            .focused(focusedField, equals: .reason)
            .onChange(of: reason) { _, newValue in
                if newValue.count > RequestMoneyViewModel.reasonLimit {
                    reason = String(newValue.prefix(RequestMoneyViewModel.reasonLimit))
                }
            }
            .padding(AppSpacing.medium)
            .background(Color.surface.opacity(0.7))
            .overlay {
                RoundedRectangle(cornerRadius: AppRadius.medium)
                    .stroke(Color.textTertiary.opacity(0.25))
            }

            Text("\(reason.count)/\(RequestMoneyViewModel.reasonLimit)")
                .font(AppTypography.cellCaption)
                .foregroundStyle(Color.textTertiary)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#Preview {
    SharedMoneyRequestCardPreviewWrapper()
}

private struct SharedMoneyRequestCardPreviewWrapper: View {
    @State private var amountText = CurrencyInputFormatter.format(80)
    @State private var reason = "Event tickets"
    @FocusState private var focusedField: RequestMoneyField?

    var body: some View {
        SharedMoneyRequestCard(
            presets: .previewPresets,
            amountText: $amountText,
            reason: $reason,
            focusedField: $focusedField,
            onPresetTap: { amountText = CurrencyInputFormatter.format($0) }
        )
        .padding()
        .appScreenBackground()
    }
}
