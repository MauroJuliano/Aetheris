import AetherisDesignSystem
import SwiftUI


#Preview {
    ScrollView {
        VStack(spacing: AppSpacing.medium) {
            IncomingPaymentDetailsSection(
                details: IncomingPaymentDetailsModel(
                    senderId: UUID(),
                    senderName: "Amelia Thompson",
                    senderContact: "amelia.thompson@aetheris.app",
                    method: "ACH",
                    methodDetails: "Checking account",
                    reference: "INV-2048"
                ),
                onSenderTap: {},
                onPaymentMethodTap: {}
            )

            TransferDetailsSection(
                details: TransferDetailsModel(
                    recipientId: UUID(),
                    recipientName: "Sophie Keller",
                    recipientContact: "+1 (617) 555-0198",
                    destinationInstitution: "Aetheris Bank",
                    method: "Instant transfer",
                    reference: "Dinner"
                ),
                onRecipientTap: {}
            )

            MerchantDetailsSection(
                details: MerchantDetailsModel(
                    merchantId: UUID(),
                    merchantName: "Apple",
                    descriptor: "APPLE.COM/BILL",
                    category: "Digital services",
                    location: "Cupertino, CA",
                    paymentMethod: CardsPreviewData.paymentMethod
                ),
                onMerchantTap: {},
                onPaymentMethodTap: {}
            )

            if let subscriptionDetails = CardsPreviewData.transaction.subscriptionDetails {
                SubscriptionDetailsSection(
                    details: subscriptionDetails,
                    onMerchantTap: {},
                    onPaymentMethodTap: {},
                    onHistoryTap: {},
                    onBlockMerchantTap: {}
                )
            }

            RefundDetailsSection(
                details: RefundDetailsModel(
                    originalTransactionId: UUID(),
                    originalMerchantName: "Swarovski",
                    originalPurchaseDate: Date(),
                    refundReason: "Returned item",
                    expectedAvailabilityDate: Calendar.current.date(
                        byAdding: .day,
                        value: 3,
                        to: Date()
                    )
                ),
                onOriginalTransactionTap: {}
            )

            InvoicePaymentDetailsSection(
                details: InvoicePaymentDetailsModel(
                    invoiceId: UUID(),
                    cardId: CardsPreviewData.cardId,
                    cardName: "Aetheris Visa",
                    billingPeriod: "Aug 2026",
                    paidAmount: 350,
                    currencyCode: "USD",
                    paymentMethod: CardsPreviewData.paymentMethod,
                    confirmationCode: "INV-98441"
                ),
                onInvoiceTap: {},
                onPaymentMethodTap: {}
            )
        }
        .padding()
        .appScreenBackground()
    }
}
