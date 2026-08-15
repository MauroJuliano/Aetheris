import AetherisDesignSystem
import SwiftUI

struct CurrentInvoiceNotice: View {
    let onDismiss: () -> Void

    var body: some View {
        HStack(spacing: AppSpacing.medium) {
            ZStack {
                Circle()
                    .fill(Color.brandPrimaryColor.opacity(0.08))
                    .frame(width: 48, height: 48)

                Image(systemName: "doc.text")
                    .font(.system(size: 21, weight: .medium))
                    .foregroundStyle(Color.brandPrimaryColor)
            }

            VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
                Text(Strings.CurrentInvoice.noticeTitle)
                    .font(AppTypography.body)
                    .bold()
                    .foregroundStyle(Color.textPrimary)

                Text(Strings.CurrentInvoice.noticeDescription)
                    .font(AppTypography.cellCaption)
                    .foregroundStyle(Color.textSecondaryColor)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: 0)

            Button(action: onDismiss) {
                Image(systemName: "xmark")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.textSecondaryColor)
                    .frame(width: 36, height: 36)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(Strings.CurrentInvoice.closeNotice)
        }
        .padding(AppSpacing.medium)
        .background(
            LinearGradient(
                colors: [
                    Color.brandPrimaryColor.opacity(0.06),
                    Color.brandTertiaryColor.opacity(0.06)
                ],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.large))
    }
}

#Preview {
    CurrentInvoiceNotice(onDismiss: {})
        .padding()
        .appScreenBackground()
}
