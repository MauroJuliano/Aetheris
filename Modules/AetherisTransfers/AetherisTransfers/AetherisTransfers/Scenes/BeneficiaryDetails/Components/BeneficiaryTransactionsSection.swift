import AetherisDesignSystem
import SwiftUI

struct BeneficiaryTransactionsSection: View {
    let summary: BeneficiaryTransactionSummaryModel
    let transactions: [BeneficiaryTransactionModel]
    let onSeeAllTap: () -> Void
    let onTransactionTap: (UUID) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            header
            transactionMetrics

            if !transactions.isEmpty {
                Divider().padding(.horizontal, AppSpacing.medium)
                recentTransactions
            }
        }
        .appCardSurface()
    }

    private var header: some View {
        HStack {
            Text(Strings.BeneficiaryDetails.transactions)
                .font(AppTypography.sectionTitle)
                .bold()
                .foregroundStyle(Color.textPrimary)

            Spacer()

            Button(action: onSeeAllTap) {
                HStack(spacing: AppSpacing.xxxSmall) {
                    Text(Strings.Common.seeAll)
                    Image(systemName: "chevron.right")
                        .font(.caption.bold())
                }
                .font(AppTypography.cellCaption)
                .bold()
                .foregroundStyle(Color.brandPrimaryColor)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, AppSpacing.medium)
        .padding(.top, AppSpacing.medium)
        .padding(.bottom, AppSpacing.small)
    }

    private var transactionMetrics: some View {
        HStack(alignment: .top, spacing: 0) {
            metric(
                title: Strings.BeneficiaryDetails.sent,
                amount: summary.sentAmount,
                count: summary.sentTransactionsCount,
                color: .textPrimary
            )

            Divider().frame(height: 72)

            metric(
                title: Strings.BeneficiaryDetails.received,
                amount: summary.receivedAmount,
                count: summary.receivedTransactionsCount,
                color: .green
            )

            Divider().frame(height: 72)

            metric(
                title: Strings.BeneficiaryDetails.net,
                amount: summary.netAmount,
                count: summary.totalTransactionsCount,
                color: summary.netAmount >= 0 ? .green : .textPrimary
            )
        }
        .padding(.horizontal, AppSpacing.medium)
        .padding(.bottom, AppSpacing.medium)
    }

    private func metric(title: String, amount: Decimal, count: Int, color: Color) -> some View {
        VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
            Text(title)
                .font(AppTypography.cellCaption)
                .foregroundStyle(Color.textSecondaryColor)

            Text(amount.formatted(.currency(code: summary.currencyCode).locale(.beneficiaryDetails)))
                .font(AppTypography.body)
                .bold()
                .foregroundStyle(color)
                .lineLimit(1)
                .minimumScaleFactor(0.75)

            Text(transactionCountText(count))
                .font(AppTypography.cellCaption)
                .foregroundStyle(Color.textSecondaryColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, AppSpacing.small)
    }

    private func transactionCountText(_ count: Int) -> String {
        count == 1
            ? Strings.BeneficiaryDetails.oneTransaction
            : Strings.BeneficiaryDetails.transactionsCount(count)
    }

    private var recentTransactions: some View {
        VStack(spacing: 0) {
            ForEach(Array(transactions.prefix(4).enumerated()), id: \.element.id) { index, transaction in
                BeneficiaryTransactionRow(transaction: transaction) {
                    onTransactionTap(transaction.id)
                }

                if index < min(transactions.count, 4) - 1 {
                    Divider().padding(.leading, 64)
                }
            }
        }
    }
}

extension BeneficiaryTransactionsSection {
    @ViewBuilder func toSkeleton(enable: Bool) -> some View {
        if enable { BeneficiaryTransactionsSectionSkeleton() } else { self }
    }
}

private struct BeneficiaryTransactionRow: View {
    let transaction: BeneficiaryTransactionModel
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: AppSpacing.medium) {
                transactionIcon

                VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
                    Text(transaction.title)
                        .font(AppTypography.body)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.textPrimary)
                        .lineLimit(1)

                    if let description = transaction.description {
                        Text(description)
                            .font(AppTypography.cellCaption)
                            .foregroundStyle(Color.textSecondaryColor)
                            .lineLimit(2)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Spacer(minLength: AppSpacing.small)

                VStack(alignment: .trailing, spacing: AppSpacing.xxxSmall) {
                    Text(transaction.formattedAmount)
                        .font(AppTypography.body)
                        .bold()
                        .foregroundStyle(transaction.isIncoming ? Color.green : Color.textPrimary)

                    Text(transaction.date.beneficiaryTransactionDateFormatted)
                        .font(AppTypography.cellCaption)
                        .foregroundStyle(Color.textSecondaryColor)
                }

                Image(systemName: "chevron.right")
                    .font(.caption.bold())
                    .foregroundStyle(Color.textTertiary)
            }
            .padding(.horizontal, AppSpacing.medium)
            .padding(.vertical, AppSpacing.small)
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    private var transactionIcon: some View {
        ZStack {
            Circle()
                .fill(transaction.isIncoming ? Color.green.opacity(0.08) : Color.brandPrimaryColor.opacity(0.08))
                .frame(width: 42, height: 42)

            Image(systemName: transaction.kind.icon)
                .font(.system(size: 17, weight: .medium))
                .foregroundStyle(transaction.isIncoming ? Color.green : Color.brandPrimaryColor)
        }
    }
}

#Preview {
    let beneficiary = BeneficiaryDetailsMockStore.beneficiary(
        for: BeneficiaryFixtures.defaultSelection.id
    )

    BeneficiaryTransactionsSection(
        summary: beneficiary.transactionSummary,
        transactions: beneficiary.recentTransactions,
        onSeeAllTap: {},
        onTransactionTap: { _ in }
    )
    .padding()
    .appScreenBackground()
}
