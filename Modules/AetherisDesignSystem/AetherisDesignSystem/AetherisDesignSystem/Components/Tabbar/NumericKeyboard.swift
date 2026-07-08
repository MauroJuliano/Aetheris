import SwiftUI

public struct NumericKeyboard: View {
    let displayedAmount: String
    let displayedBalance: String
    let balanceLabel: String
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
        balanceLabel: String = "Wallet balance:",
        onKeyPressed: @escaping (String) -> Void
    ) {
        self.displayedAmount = displayedAmount
        self.displayedBalance = displayedBalance
        self.balanceLabel = balanceLabel
        self.onKeyPressed = onKeyPressed
    }

    public var body: some View {
        VStack(spacing: AppSpacing.xLarge - AppSpacing.xSmall) {
            amountHeader

            VStack(spacing: AppComponentMetrics.keyboardRowSpacing) {
                ForEach(keys, id: \.self) { row in
                    HStack(spacing: AppComponentMetrics.keyboardKeySpacing) {
                        ForEach(row, id: \.self) { key in
                            keyboardButton(key)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, AppComponentMetrics.keyboardContainerHorizontalPadding)
        .padding(.top, AppComponentMetrics.keyboardContainerTopPadding)
        .padding(.bottom, AppComponentMetrics.keyboardContainerBottomPadding)
        .background(
            RoundedRectangle(cornerRadius: AppRadius.large + AppRadius.medium, style: .continuous)
                .fill(Color.backgroundColorA)
                .appShadow(AppShadow.soft)
        )
    }

    private var amountHeader: some View {
        VStack(spacing: 8) {
            Text(displayedAmount)
                .foregroundStyle(.black)
                .font(.largeTitle)
                .bold()
                .contentTransition(.numericText())

            HStack {
                Text(balanceLabel)
                    .foregroundStyle(Color.gray.opacity(0.85))
                    .font(.subheadline)
                
                Text(displayedBalance)
                    .foregroundStyle(Color.brandPrimaryColor)
                    .font(.subheadline)
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
            .frame(height: AppComponentMetrics.keyboardKeyHeight)
            .background(
                RoundedRectangle(cornerRadius: AppComponentMetrics.keyboardKeyCornerRadius, style: .continuous)
                    .fill(Color.backgroundColorA.opacity(0.95))
                    .appShadow(AppShadow.control)
                    .overlay(
                        RoundedRectangle(cornerRadius: AppComponentMetrics.keyboardKeyCornerRadius, style: .continuous)
                            .stroke(.white.opacity(0.8), lineWidth: 1)
                    )
            )
        }
        .buttonStyle(.plain)
    }
}
