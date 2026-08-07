import AetherisDesignSystem
import SwiftUI

struct TransactionDetailsHeader: View {
    let transaction: TransactionDetailsModel

    var body: some View {
        VStack(spacing: AppSpacing.small) {
            avatar

            Text(transaction.title)
                .font(AppTypography.sectionTitle)
                .bold()
                .foregroundStyle(Color.textPrimary)
                .multilineTextAlignment(.center)

            Text(transaction.formattedAmount)
                .font(.system(size: 40, weight: .semibold))
                .foregroundStyle(transaction.accentColor)
                .minimumScaleFactor(0.75)
                .lineLimit(1)

            categoryBadge

            if let subtitle = transaction.subtitle {
                Text(subtitle)
                    .font(AppTypography.body)
                    .foregroundStyle(Color.textSecondaryColor)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, AppSpacing.medium)
        .padding(.vertical, AppSpacing.large)
        .background(
            LinearGradient(
                colors: [
                    transaction.accentColor.opacity(0.08),
                    transaction.accentColor.opacity(0.02)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.large))
    }

    private var categoryBadge: some View {
        Label(transaction.categoryTitle, systemImage: transaction.categoryIcon)
            .font(AppTypography.cellCaption)
            .bold()
            .foregroundStyle(transaction.accentColor)
            .padding(.horizontal, AppSpacing.small)
            .padding(.vertical, AppSpacing.xSmall)
            .background(transaction.accentColor.opacity(0.1))
            .clipShape(Capsule())
    }

    @ViewBuilder
    private var avatar: some View {
        if let imageName = transaction.imageName {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 92, height: 92)
                .clipShape(Circle())
        } else {
            ZStack {
                Circle()
                    .fill(transaction.accentColor.opacity(0.1))
                    .frame(width: 92, height: 92)

                Image(systemName: transaction.categoryIcon)
                    .font(.system(size: 34, weight: .medium))
                    .foregroundStyle(transaction.accentColor)
            }
        }
    }
}
