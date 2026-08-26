import AetherisDesignSystem
import Foundation
import SwiftUI

struct SubscriptionDetailsSection: View {
    let details: SubscriptionDetailsModel
    let onMerchantTap: () -> Void
    let onPaymentMethodTap: () -> Void
    let onHistoryTap: () -> Void
    let onBlockMerchantTap: () -> Void
    let isLoading: Bool

    init(
        details: SubscriptionDetailsModel,
        onMerchantTap: @escaping () -> Void,
        onPaymentMethodTap: @escaping () -> Void,
        onHistoryTap: @escaping () -> Void,
        onBlockMerchantTap: @escaping () -> Void,
        isLoading: Bool = false
    ) {
        self.details = details
        self.onMerchantTap = onMerchantTap
        self.onPaymentMethodTap = onPaymentMethodTap
        self.onHistoryTap = onHistoryTap
        self.onBlockMerchantTap = onBlockMerchantTap
        self.isLoading = isLoading
    }

    var body: some View {
        VStack(spacing: AppSpacing.medium) {
            if isLoading {
                recurringPaymentCardSkeleton
                subscriptionDetailsCardSkeleton
                paymentHistoryCardSkeleton
                merchantControlCardSkeleton
            } else {
                if details.isRecurringPaymentDetected {
                    recurringPaymentCard
                }

                subscriptionDetailsCard

                if !details.paymentHistory.isEmpty {
                    paymentHistoryCard
                }

                merchantControlCard
            }
        }
    }

    private var recurringPaymentCard: some View {
        HStack(spacing: AppSpacing.medium) {
            iconCircle(
                systemName: "arrow.triangle.2.circlepath",
                color: .brandPrimaryColor,
                size: 50
            )

            VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
                Text(Strings.TransactionDetails.recurringPayment)
                    .font(AppTypography.body)
                    .bold()
                    .foregroundStyle(Color.textPrimary)

                Text(recurringDescription)
                    .font(AppTypography.cellCaption)
                    .foregroundStyle(Color.textSecondaryColor)
                    .fixedSize(horizontal: false, vertical: true)

                if let nextDate = details.nextExpectedPaymentDate {
                    Text(Strings.TransactionDetails.nextExpectedPayment(nextDate.shortTransactionDateFormatted))
                        .font(AppTypography.cellCaption)
                        .bold()
                        .foregroundStyle(Color.brandPrimaryColor)
                }
            }

            Spacer(minLength: 0)
        }
        .padding(AppSpacing.medium)
        .background(Color.brandPrimaryColor.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.large))
    }

    private var recurringPaymentCardSkeleton: some View {
        HStack(spacing: AppSpacing.medium) {
            SkeletonView(.circle)
                .frame(width: 50, height: 50)

            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                SkeletonBlock(width: 150, height: 16, radius: 8)
                SkeletonBlock(width: 220, height: 14, radius: 7)
                SkeletonBlock(width: 180, height: 13, radius: 6)
            }

            Spacer(minLength: 0)
        }
        .padding(AppSpacing.medium)
        .background(Color.brandPrimaryColor.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.large))
    }

    private var subscriptionDetailsCard: some View {
        TransactionDetailsCard(
            title: Strings.TransactionDetails.subscriptionDetails,
            isLoading: false
        ) {
            TransactionDetailRow(
                title: Strings.TransactionDetails.merchant,
                icon: "storefront",
                value: details.merchantName,
                subtitle: details.merchantDescriptor,
                showsChevron: true,
                action: onMerchantTap
            )
            TransactionDetailsDivider()

            TransactionDetailRow(
                title: Strings.TransactionDetails.category,
                icon: "square.grid.2x2",
                value: details.category
            )
            TransactionDetailsDivider()

            TransactionDetailRow(
                title: Strings.TransactionDetails.billingFrequency,
                icon: "calendar.badge.clock",
                value: details.billingFrequency.title
            )

            if let nextDate = details.nextExpectedPaymentDate {
                TransactionDetailsDivider()

                TransactionDetailRow(
                    title: Strings.TransactionDetails.nextPayment,
                    icon: "calendar",
                    value: nextDate.shortTransactionDateFormatted
                )
            }

            TransactionDetailsDivider()

            TransactionDetailRow(
                title: Strings.TransactionDetails.expectedAmount,
                icon: "dollarsign.circle",
                value: details.expectedAmount.absoluteCurrencyFormatted(code: details.currencyCode)
            )
            TransactionDetailsDivider()

            TransactionDetailRow(
                title: Strings.TransactionDetails.paymentMethod,
                icon: details.paymentMethod.icon,
                value: details.paymentMethod.displayTitle,
                subtitle: details.paymentMethod.subtitle,
                showsChevron: true,
                action: onPaymentMethodTap
            )
        }
    }

    private var subscriptionDetailsCardSkeleton: some View {
        TransactionDetailsCard(
            title: Strings.TransactionDetails.subscriptionDetails,
            isLoading: true
        ) {
            TransactionDetailRow(
                title: Strings.TransactionDetails.merchant,
                icon: "storefront",
                value: details.merchantName,
                subtitle: details.merchantDescriptor,
                showsChevron: true,
                action: onMerchantTap
            )
            .toSkeleton(enable: true)

            TransactionDetailsDivider()

            TransactionDetailRow(
                title: Strings.TransactionDetails.category,
                icon: "square.grid.2x2",
                value: details.category
            )
            .toSkeleton(enable: true)

            TransactionDetailsDivider()

            TransactionDetailRow(
                title: Strings.TransactionDetails.billingFrequency,
                icon: "calendar.badge.clock",
                value: details.billingFrequency.title
            )
            .toSkeleton(enable: true)

            if let nextDate = details.nextExpectedPaymentDate {
                TransactionDetailsDivider()

                TransactionDetailRow(
                    title: Strings.TransactionDetails.nextPayment,
                    icon: "calendar",
                    value: nextDate.shortTransactionDateFormatted
                )
                .toSkeleton(enable: true)
            }

            TransactionDetailsDivider()

            TransactionDetailRow(
                title: Strings.TransactionDetails.expectedAmount,
                icon: "dollarsign.circle",
                value: details.expectedAmount.absoluteCurrencyFormatted(code: details.currencyCode)
            )
            .toSkeleton(enable: true)

            TransactionDetailsDivider()

            TransactionDetailRow(
                title: Strings.TransactionDetails.paymentMethod,
                icon: details.paymentMethod.icon,
                value: details.paymentMethod.displayTitle,
                subtitle: details.paymentMethod.subtitle,
                showsChevron: true,
                action: onPaymentMethodTap
            )
            .toSkeleton(enable: true)
        }
    }

    private var paymentHistoryCard: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(Strings.TransactionDetails.paymentHistory)
                    .font(AppTypography.sectionTitle)
                    .bold()
                    .foregroundStyle(Color.textPrimary)

                Spacer()

                Button(Strings.Common.seeAll, action: onHistoryTap)
                    .font(AppTypography.cellCaption)
                    .bold()
                    .foregroundStyle(Color.brandPrimaryColor)
                    .buttonStyle(.plain)
            }
            .padding(.horizontal, AppSpacing.medium)
            .padding(.top, AppSpacing.medium)
            .padding(.bottom, AppSpacing.small)

            ForEach(Array(details.paymentHistory.prefix(3).enumerated()), id: \.element.id) { index, payment in
                SubscriptionPaymentHistoryRow(payment: payment)

                if index < min(details.paymentHistory.count, 3) - 1 {
                    Divider().padding(.leading, AppSpacing.medium)
                }
            }
        }
        .appCardSurface()
    }

    private var paymentHistoryCardSkeleton: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                SkeletonBlock(width: 160, height: 20, radius: 9)

                Spacer()

                SkeletonBlock(width: 70, height: 16, radius: 8)
            }
            .padding(.horizontal, AppSpacing.medium)
            .padding(.top, AppSpacing.medium)
            .padding(.bottom, AppSpacing.small)

            ForEach(0..<3, id: \.self) { index in
                HStack(spacing: AppSpacing.medium) {
                    VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                        SkeletonBlock(width: 100, height: 13, radius: 6)
                        SkeletonBlock(width: 130, height: 16, radius: 8)
                    }

                    Spacer()

                    SkeletonBlock(width: 80, height: 16, radius: 8)
                }
                .padding(.horizontal, AppSpacing.medium)
                .padding(.vertical, AppSpacing.small)

                if index < 2 {
                    Divider().padding(.leading, AppSpacing.medium)
                }
            }
        }
        .appCardSurface()
    }

    private var merchantControlCard: some View {
        Button(action: onBlockMerchantTap) {
            HStack(spacing: AppSpacing.medium) {
                iconCircle(
                    systemName: details.merchantIsBlocked ? "checkmark.shield" : "hand.raised",
                    color: details.merchantIsBlocked ? .green : .red,
                    size: 46
                )

                VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
                    Text(details.merchantIsBlocked ? Strings.TransactionDetails.allowFuturePayments : Strings.TransactionDetails.blockFuturePayments)
                        .font(AppTypography.body)
                        .bold()
                        .foregroundStyle(Color.textPrimary)

                    Text(details.merchantIsBlocked ? Strings.TransactionDetails.allowFuturePaymentsDescription : Strings.TransactionDetails.blockFuturePaymentsDescription)
                        .font(AppTypography.cellCaption)
                        .foregroundStyle(Color.textSecondaryColor)
                        .multilineTextAlignment(.leading)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption.bold())
                    .foregroundStyle(Color.textTertiary)
            }
            .padding(AppSpacing.medium)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .appCardSurface()
    }

    private var merchantControlCardSkeleton: some View {
        HStack(spacing: AppSpacing.medium) {
            SkeletonView(.circle)
                .frame(width: 46, height: 46)

            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                SkeletonBlock(width: 170, height: 16, radius: 8)
                SkeletonBlock(width: 240, height: 14, radius: 7)
            }

            Spacer()

            SkeletonBlock(width: 10, height: 16, radius: 5)
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }

    private var recurringDescription: String {
        let amount = details.expectedAmount.absoluteCurrencyFormatted(code: details.currencyCode)

        switch details.billingFrequency {
        case .weekly:
            return Strings.TransactionDetails.recurringWeekly(details.merchantName, amount)
        case .monthly:
            return Strings.TransactionDetails.recurringMonthly(details.merchantName, amount)
        case .quarterly:
            return Strings.TransactionDetails.recurringQuarterly(details.merchantName, amount)
        case .yearly:
            return Strings.TransactionDetails.recurringYearly(details.merchantName, amount)
        case .unknown:
            return Strings.TransactionDetails.recurringUnknown
        }
    }
}
