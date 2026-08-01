import SwiftUI

public struct BalanceView: View {
    @State private var isBalanceVisible = true
    private let title: String
    private let balanceText: String

    public init(
        title: String = "Balance",
        balanceText: String = "$ 13,553.00"
    ) {
        self.title = title
        self.balanceText = balanceText
    }

    public var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(AppTypography.navTitle)
                .foregroundStyle(Color.textTertiary)

            HStack(spacing: AppSpacing.small) {
                Text(isBalanceVisible ? balanceText : maskedBalanceText)
                    .font(AppTypography.balanceAmount)
                    .bold()
                    .foregroundStyle(Color.textPrimary)

                Button {
                    isBalanceVisible.toggle()
                } label: {
                    Image(systemName: isBalanceVisible ? "eye" : "eye.slash")
                        .font(.system(size: AppComponentMetrics.balanceEyeSize, weight: .medium))
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
