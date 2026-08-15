import AetherisDesignSystem
import SwiftUI

struct TransactionDetailRow: View {
    let title: String
    let icon: String
    let value: String
    var subtitle: String?
    var valueColor: Color = .textPrimary
    var showsChevron = false
    var action: (() -> Void)?

    var body: some View {
        Group {
            if let action {
                Button(action: action) {
                    rowContent
                }
                .buttonStyle(.plain)
            } else {
                rowContent
            }
        }
    }

    private var rowContent: some View {
        HStack(spacing: AppSpacing.medium) {
            ZStack {
                Circle()
                    .fill(Color.brandPrimaryColor.opacity(0.08))
                    .frame(width: 40, height: 40)

                Image(systemName: icon)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(Color.brandPrimaryColor)
            }

            Text(title)
                .font(AppTypography.body)
                .foregroundStyle(Color.textSecondaryColor)

            Spacer(minLength: AppSpacing.small)

            VStack(alignment: .trailing, spacing: AppSpacing.xxxSmall) {
                Text(value)
                    .font(AppTypography.body)
                    .fontWeight(.medium)
                    .foregroundStyle(valueColor)
                    .multilineTextAlignment(.trailing)
                    .lineLimit(2)

                if let subtitle {
                    Text(subtitle)
                        .font(AppTypography.cellCaption)
                        .foregroundStyle(Color.textSecondaryColor)
                        .multilineTextAlignment(.trailing)
                        .lineLimit(2)
                }
            }

            if showsChevron {
                Image(systemName: "chevron.right")
                    .font(.caption.bold())
                    .foregroundStyle(Color.textTertiary)
            }
        }
        .padding(.vertical, AppSpacing.small)
        .contentShape(Rectangle())
    }
}

#Preview {
    VStack(spacing: 0) {
        TransactionDetailRow(
            title: "Merchant",
            icon: "storefront",
            value: "Netflix",
            subtitle: "NETFLIX.COM",
            showsChevron: true,
            action: {}
        )

        Divider()
            .padding(.leading, 52)

        TransactionDetailRow(
            title: "Status",
            icon: "checkmark.circle.fill",
            value: "Completed",
            valueColor: .green
        )
    }
    .padding(.horizontal, AppSpacing.medium)
    .appCardSurface()
    .padding()
    .appScreenBackground()
}
