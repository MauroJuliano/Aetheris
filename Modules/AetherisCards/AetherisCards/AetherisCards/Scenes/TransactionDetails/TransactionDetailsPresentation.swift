import SwiftUI

enum TransactionDetailsSectionKind: Equatable {
    case incomingPayment
    case outgoingTransfer
    case purchase
    case subscription
    case refund
    case invoicePayment
}

extension TransactionDetailsModel {
    var sectionKind: TransactionDetailsSectionKind {
        switch kind {
        case .incomingPayment:
            return .incomingPayment
        case .outgoingTransfer:
            return .outgoingTransfer
        case .purchase:
            return .purchase
        case .subscription:
            return .subscription
        case .refund:
            return .refund
        case .invoicePayment:
            return .invoicePayment
        }
    }
}

enum TransactionDetailsSectionFactory {
    @ViewBuilder
    static func make(
        transaction: TransactionDetailsModel,
        onMerchantTap: @escaping (UUID) -> Void,
        onPaymentMethodTap: @escaping (UUID) -> Void,
        onTransactionHistoryTap: @escaping (UUID) -> Void,
        onBlockMerchantTap: @escaping (UUID) -> Void,
        isLoading: Bool = false
    ) -> some View {
        switch transaction.sectionKind {
        case .incomingPayment:
            if let details = transaction.incomingPaymentDetails {
                IncomingPaymentDetailsSection(
                    details: details,
                    onSenderTap: { onMerchantTap(details.senderId) },
                    onPaymentMethodTap: { onPaymentMethodTap(transaction.id) },
                    isLoading: isLoading
                )
            }
        case .outgoingTransfer:
            if let details = transaction.transferDetails {
                TransferDetailsSection(
                    details: details,
                    onRecipientTap: { onMerchantTap(details.recipientId) },
                    isLoading: isLoading
                )
            }
        case .purchase:
            if let details = transaction.merchantDetails {
                MerchantDetailsSection(
                    details: details,
                    onMerchantTap: { onMerchantTap(details.merchantId) },
                    onPaymentMethodTap: { onPaymentMethodTap(transaction.id) },
                    isLoading: isLoading
                )
            }
        case .subscription:
            if let details = transaction.subscriptionDetails {
                SubscriptionDetailsSection(
                    details: details,
                    onMerchantTap: { onMerchantTap(details.merchantId) },
                    onPaymentMethodTap: { onPaymentMethodTap(transaction.id) },
                    onHistoryTap: { onTransactionHistoryTap(details.merchantId) },
                    onBlockMerchantTap: { onBlockMerchantTap(details.merchantId) },
                    isLoading: isLoading
                )
            }
        case .refund:
            if let details = transaction.refundDetails {
                RefundDetailsSection(
                    details: details,
                    onOriginalTransactionTap: {
                        onTransactionHistoryTap(details.originalTransactionId)
                    },
                    isLoading: isLoading
                )
            }
        case .invoicePayment:
            if let details = transaction.invoicePaymentDetails {
                InvoicePaymentDetailsSection(
                    details: details,
                    onInvoiceTap: { onTransactionHistoryTap(details.invoiceId) },
                    onPaymentMethodTap: { onPaymentMethodTap(transaction.id) },
                    isLoading: isLoading
                )
            }
        }
    }
}
