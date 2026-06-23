import SwiftUI

public struct BalanceView: View {
    @State private var isBalanceVisible = true

    public init() {}

    public var body: some View {
        VStack(alignment: .leading) {
            Text("Balance")
                .font(.system(size: 22, weight: .medium))
                .foregroundStyle(Color.textTertiary)

            HStack(spacing: 12) {
                Text(isBalanceVisible ? "$ 13,553.00" : "••••••••")
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
        .padding(.top)
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    BalanceView()
}
