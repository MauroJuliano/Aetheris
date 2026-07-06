import SwiftUI

struct TransactionTag: View {
    let type: TransactionType

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: type.icon)
                .font(.system(size: 9, weight: .bold))

            Text(type.title)
                .font(.system(size: 11, weight: .semibold))
        }
        .foregroundStyle(type.color)
        .padding(.horizontal, 8)
        .padding(.vertical, 5)
        .background(
            Capsule()
                .fill(type.color.opacity(0.12))
        )
    }
}

#Preview {
    TransactionTag(type: .income)
}
