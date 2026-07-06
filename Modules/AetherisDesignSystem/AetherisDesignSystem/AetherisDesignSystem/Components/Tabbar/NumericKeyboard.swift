import SwiftUI

public struct NumericKeyboard: View {
    let displayedAmount: String
    let displayedBalance: String
    let onKeyPressed: (String) -> Void

    private let keys = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        [".", "0", "delete.left"]
    ]

    public init(
        displayedAmount: String,
        displayedBalance: String,
        onKeyPressed: @escaping (String) -> Void
    ) {
        self.displayedAmount = displayedAmount
        self.displayedBalance = displayedBalance
        self.onKeyPressed = onKeyPressed
    }

    public var body: some View {
        VStack(spacing: 22) {
            amountHeader

            VStack(spacing: 14) {
                ForEach(keys, id: \.self) { row in
                    HStack(spacing: 16) {
                        ForEach(row, id: \.self) { key in
                            keyboardButton(key)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 34)
        .padding(.top, 38)
        .padding(.bottom, 28)
        .background(
            RoundedRectangle(cornerRadius: 34, style: .continuous)
                .fill(Color.backgroundColorA)
                .shadow(
                    color: .black.opacity(0.08),
                    radius: 28,
                    x: 12,
                    y: 18
                )
        )
    }

    private var amountHeader: some View {
        VStack(spacing: 8) {
            Text(displayedAmount)
                .foregroundStyle(Color.textPrimary)
                .font(AppTypography.screenTitle)
                .bold()
                .contentTransition(.numericText())

            HStack  {
                Text("Wallet balance:")
                    .foregroundStyle(Color.textSecondaryColor)
                    .font(AppTypography.subheadline)
                
                Text(displayedBalance)
                    .foregroundStyle(Color.brandPrimaryColor)
                    .font(AppTypography.subheadline)
            }
        }
        .padding(.bottom, 12)
    }

    private func keyboardButton(_ key: String) -> some View {
        Button {
            onKeyPressed(key)
        } label: {
            Group {
                if key == "delete.left" {
                    Image(systemName: key)
                        .font(.system(size: 28, weight: .regular))
                } else {
                    Text(key)
                        .font(AppFont.roboto(.regular, size: 34))
                }
            }
            .foregroundStyle(Color.brandPrimaryColor)
            .frame(maxWidth: .infinity)
            .frame(height: 58)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(Color.backgroundColorA.opacity(0.95))
                    .appShadow(AppShadow.chartGlow)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .stroke(.white.opacity(0.8), lineWidth: 1)
                    )
            )
        }
        .buttonStyle(.plain)
    }
}
