import AetherisDesignSystem
import SwiftUI

struct RequestMoneyFormCard: View {
    let contacts: [RequestContactModel]
    let selectedContact: RequestContactModel?
    let presets: [RequestMoneyAmountPresetModel]

    @Binding var amountText: String
    @Binding var reason: String

    let focusedField: FocusState<RequestMoneyField?>.Binding
    let onSearchTap: () -> Void
    let onContactTap: (RequestContactModel) -> Void
    let onPresetTap: (Decimal) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.large) {
            recipientSection

            Divider()

            amountSection

            reasonSection
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }

    private var recipientSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium) {
            Text(Strings.RequestMoney.recipientTitle)
                .font(AppTypography.body)
                .foregroundStyle(Color.textSecondaryColor)

            Button(action: onSearchTap) {
                HStack(spacing: AppSpacing.small) {
                    recipientIcon

                    VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
                        Text(recipientTitle)
                            .font(AppTypography.body)
                            .fontWeight(.medium)
                            .foregroundStyle(Color.textPrimary)
                            .lineLimit(1)

                        Text(recipientSubtitle)
                            .font(AppTypography.cellCaption)
                            .foregroundStyle(Color.textSecondaryColor)
                            .lineLimit(1)
                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.caption.bold())
                        .foregroundStyle(Color.brandPrimaryColor)
                }
                .padding(.horizontal, AppSpacing.medium)
                .frame(height: 66)
                .background(Color.surface.opacity(0.7))
                .overlay {
                    RoundedRectangle(cornerRadius: AppRadius.medium)
                        .stroke(Color.textTertiary.opacity(0.25))
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            if !contacts.isEmpty {
                recentContacts
            }
        }
    }

    @ViewBuilder
    private var recipientIcon: some View {
        if let imageName = selectedContact?.imageName,
           !imageName.isEmpty {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 42, height: 42)
                .clipShape(Circle())
        } else {
            ZStack {
                Circle()
                    .fill(Color.brandPrimaryColor.opacity(0.08))
                    .frame(width: 42, height: 42)

                Image(systemName: "person")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(Color.brandPrimaryColor)
            }
        }
    }

    private var recipientTitle: String {
        selectedContact?.name ?? Strings.RequestMoney.selectBeneficiaryTitle
    }

    private var recipientSubtitle: String {
        selectedContact?.contactInformation ?? Strings.RequestMoney.selectBeneficiaryDescription
    }

    private var recentContacts: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text(Strings.RequestMoney.recentContacts)
                .font(AppTypography.cellCaption)
                .foregroundStyle(Color.textSecondaryColor)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppSpacing.medium) {
                    ForEach(contacts) { contact in
                        RecentContactButton(
                            contact: contact,
                            isSelected: contact.id == selectedContact?.id
                        ) {
                            onContactTap(contact)
                        }
                    }
                }
            }
        }
    }

    private var amountSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium) {
            Text(Strings.RequestMoney.amountTitle)
                .font(AppTypography.body)
                .foregroundStyle(Color.textSecondaryColor)

            HStack(alignment: .center) {
                TextField("R$ 0,00", text: $amountText)
                    .font(.system(size: 38, weight: .semibold))
                    .foregroundStyle(Color.textPrimary)
                    .keyboardType(.numberPad)
                    .focused(focusedField, equals: .amount)
                    .onChange(of: amountText) { _, newValue in
                        amountText = CurrencyInputFormatter.format(newValue)
                    }
                    .accessibilityIdentifier("requestMoney.amount")

                Spacer()

                Button {
                    focusedField.wrappedValue = .amount
                } label: {
                    Label(Strings.RequestMoney.edit, systemImage: "pencil")
                        .font(AppTypography.cellCaption)
                        .bold()
                        .foregroundStyle(Color.brandPrimaryColor)
                }
                .buttonStyle(.plain)
            }

            AmountPresets(
                amountText: amountText,
                presets: presets,
                onPresetTap: onPresetTap
            )
        }
    }

    private var reasonSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
            Text(Strings.RequestMoney.reasonTitle)
                .font(AppTypography.body)
                .foregroundStyle(Color.textSecondaryColor)

            HStack(alignment: .top, spacing: AppSpacing.small) {
                Image(systemName: "message")
                    .font(.system(size: 17))
                    .foregroundStyle(Color.textSecondaryColor)
                    .padding(.top, AppSpacing.xxxSmall)

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

#Preview {
    RequestMoneyFormCardPreviewWrapper()
}

private struct RequestMoneyFormCardPreviewWrapper: View {
    @State private var amountText = CurrencyInputFormatter.format(125)
    @State private var reason = "Dinner split"
    @FocusState private var focusedField: RequestMoneyField?

    var body: some View {
        RequestMoneyFormCard(
            contacts: [.previewSophie, .previewCarlos],
            selectedContact: .previewSophie,
            presets: .previewPresets,
            amountText: $amountText,
            reason: $reason,
            focusedField: $focusedField,
            onSearchTap: {},
            onContactTap: { _ in },
            onPresetTap: { amountText = CurrencyInputFormatter.format($0) }
        )
        .padding()
        .appScreenBackground()
    }
}

extension Array where Element == RequestMoneyAmountPresetModel {
    static let previewPresets: [RequestMoneyAmountPresetModel] = [
        .init(id: "50", value: 50),
        .init(id: "100", value: 100),
        .init(id: "150", value: 150),
        .init(id: "200", value: 200)
    ]
}
