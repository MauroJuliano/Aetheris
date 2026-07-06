import SwiftUI

public struct BalanceView: View {
    @State private var isBalanceVisible = true
    private let balanceText = "$ 13,553.00"

    public init() {}

    public var body: some View {
        VStack(alignment: .leading) {
            Text("Balance")
                .font(AppTypography.navTitle)
                .foregroundStyle(Color.textTertiary)

            HStack(spacing: AppSpacing.small) {
                Text(isBalanceVisible ? balanceText : maskedBalanceText)
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color.textPrimary)

                Button {
                    isBalanceVisible.toggle()
                } label: {
                    Image(systemName: isBalanceVisible ? "eye" : "eye.slash")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(Color.textTertiary)
                }
            }
        }
        .padding(.top, AppSpacing.medium)
        .padding(.horizontal, AppSpacing.screenHorizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var maskedBalanceText: String {
        guard let separatorIndex = balanceText.firstIndex(of: " ") else {
            return String(repeating: "•", count: balanceText.count)
        }

        let prefix = balanceText[...separatorIndex]
        let amount = balanceText[balanceText.index(after: separatorIndex)...]

        return prefix + String(repeating: "•", count: amount.count)
    }
}

#Preview {
    BalanceView()
}
