import AetherisDesignSystem
import Foundation
import SwiftUI

struct MerchantDetailsSection: View {
    let details: MerchantDetailsModel
    let onMerchantTap: () -> Void
    let onPaymentMethodTap: () -> Void
    let isLoading: Bool

    init(
        details: MerchantDetailsModel,
        onMerchantTap: @escaping () -> Void,
        onPaymentMethodTap: @escaping () -> Void,
        isLoading: Bool = false
    ) {
        self.details = details
        self.onMerchantTap = onMerchantTap
        self.onPaymentMethodTap = onPaymentMethodTap
        self.isLoading = isLoading
    }

    var body: some View {
        TransactionDetailsCard(
            title: Strings.TransactionDetails.purchaseDetails,
            isLoading: isLoading
        ) {
            TransactionDetailRow(
                title: Strings.TransactionDetails.merchant,
                icon: "storefront",
                value: details.merchantName,
                subtitle: details.descriptor,
                showsChevron: true,
                action: onMerchantTap
            )
            .toSkeleton(enable: isLoading)

            TransactionDetailsDivider()

            TransactionDetailRow(
                title: Strings.TransactionDetails.category,
                icon: "square.grid.2x2",
                value: details.category
            )
            .toSkeleton(enable: isLoading)

            if let location = details.location {
                TransactionDetailsDivider()

                TransactionDetailRow(
                    title: Strings.TransactionDetails.location,
                    icon: "mappin",
                    value: location
                )
                .toSkeleton(enable: isLoading)
            }

            TransactionDetailsDivider()

            TransactionDetailRow(
                title: Strings.TransactionDetails.paymentMethod,
                icon: details.paymentMethod.icon,
                value: details.paymentMethod.displayTitle,
                subtitle: details.paymentMethod.subtitle,
                showsChevron: true,
                action: onPaymentMethodTap
            )
            .toSkeleton(enable: isLoading)
        }
    }
}
