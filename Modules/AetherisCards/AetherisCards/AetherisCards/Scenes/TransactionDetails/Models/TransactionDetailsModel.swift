import Foundation
import SwiftUI

struct TransactionDetailsModel: Identifiable, Codable, Equatable {
    let id: UUID
    let title: String
    let subtitle: String?
    let amount: Decimal
    let currencyCode: String
    let kind: TransactionKind
    let status: TransactionStatus
    let date: Date
    let transactionCode: String
    let note: String?
    let imageName: String?
    let imageURL: URL?
    let incomingPaymentDetails: IncomingPaymentDetailsModel?
    let transferDetails: TransferDetailsModel?
    let merchantDetails: MerchantDetailsModel?
    let subscriptionDetails: SubscriptionDetailsModel?
    let refundDetails: RefundDetailsModel?
    let invoicePaymentDetails: InvoicePaymentDetailsModel?
    let availableActions: [TransactionAction]

    var isIncome: Bool {
        switch kind {
        case .incomingPayment, .refund:
            return true
        case .outgoingTransfer, .purchase, .subscription, .invoicePayment:
            return false
        }
    }

    var formattedAmount: String {
        let formatted = abs(amount).formatted(.currency(code: currencyCode).locale(.transactionDetails))
        return isIncome ? "+\(formatted)" : "-\(formatted)"
    }

    var categoryTitle: String {
        switch kind {
        case .incomingPayment:
            return Strings.TransactionDetails.income
        case .outgoingTransfer:
            return Strings.TransactionDetails.transfer
        case .purchase:
            return Strings.TransactionDetails.purchase
        case .subscription:
            return Strings.TransactionDetails.subscription
        case .refund:
            return Strings.TransactionDetails.refund
        case .invoicePayment:
            return Strings.TransactionDetails.invoicePayment
        }
    }

    var categoryIcon: String {
        switch kind {
        case .incomingPayment:
            return "arrow.down"
        case .outgoingTransfer:
            return "arrow.up.right"
        case .purchase:
            return "bag"
        case .subscription:
            return "arrow.triangle.2.circlepath"
        case .refund:
            return "arrow.uturn.backward"
        case .invoicePayment:
            return "doc.text"
        }
    }

    var accentColor: Color {
        isIncome ? .green : .brandPrimaryColor
    }
}

enum TransactionKind: String, Codable, Equatable {
    case incomingPayment
    case outgoingTransfer
    case purchase
    case subscription
    case refund
    case invoicePayment
}

enum TransactionStatus: String, Codable, Equatable {
    case pending
    case processing
    case completed
    case declined
    case cancelled
    case refunded

    var title: String {
        switch self {
        case .pending:
            return Strings.TransactionDetails.pending
        case .processing:
            return Strings.TransactionDetails.processing
        case .completed:
            return Strings.TransactionDetails.completed
        case .declined:
            return Strings.TransactionDetails.declined
        case .cancelled:
            return Strings.TransactionDetails.cancelled
        case .refunded:
            return Strings.TransactionDetails.refundedStatus
        }
    }

    var icon: String {
        switch self {
        case .pending:
            return "clock"
        case .processing:
            return "arrow.triangle.2.circlepath"
        case .completed:
            return "checkmark.circle.fill"
        case .declined:
            return "xmark.circle.fill"
        case .cancelled:
            return "minus.circle.fill"
        case .refunded:
            return "arrow.uturn.backward.circle.fill"
        }
    }

    var color: Color {
        switch self {
        case .pending, .processing:
            return .orange
        case .completed:
            return .green
        case .declined:
            return .red
        case .cancelled:
            return Color.textSecondaryColor
        case .refunded:
            return .brandPrimaryColor
        }
    }
}

enum TransactionAction: String, Codable, Identifiable, Equatable {
    case share
    case download
    case addNote
    case reportIssue

    var id: String { rawValue }

    var title: String {
        switch self {
        case .share:
            return Strings.TransactionDetails.share
        case .download:
            return Strings.TransactionDetails.download
        case .addNote:
            return Strings.TransactionDetails.addNote
        case .reportIssue:
            return Strings.TransactionDetails.reportIssue
        }
    }

    var icon: String {
        switch self {
        case .share:
            return "square.and.arrow.up"
        case .download:
            return "arrow.down.to.line"
        case .addNote:
            return "square.and.pencil"
        case .reportIssue:
            return "flag"
        }
    }
}

struct IncomingPaymentDetailsModel: Codable, Equatable {
    let senderId: UUID
    let senderName: String
    let senderContact: String?
    let method: String
    let methodDetails: String?
    let reference: String?
}

struct TransferDetailsModel: Codable, Equatable {
    let recipientId: UUID
    let recipientName: String
    let recipientContact: String?
    let destinationInstitution: String?
    let method: String
    let reference: String?
}

struct MerchantDetailsModel: Codable, Equatable {
    let merchantId: UUID
    let merchantName: String
    let descriptor: String?
    let category: String
    let location: String?
    let paymentMethod: PaymentMethodSummaryModel
}

struct SubscriptionDetailsModel: Codable, Equatable {
    let merchantId: UUID
    let merchantName: String
    let merchantDescriptor: String?
    let merchantImageName: String?
    let category: String
    let billingFrequency: BillingFrequency
    let lastPaymentDate: Date
    let nextExpectedPaymentDate: Date?
    let expectedAmount: Decimal
    let currencyCode: String
    let paymentMethod: PaymentMethodSummaryModel
    let paymentHistory: [SubscriptionPaymentHistoryModel]
    let isRecurringPaymentDetected: Bool
    let merchantIsBlocked: Bool
}

enum BillingFrequency: String, Codable, Equatable {
    case weekly
    case monthly
    case quarterly
    case yearly
    case unknown

    var title: String {
        switch self {
        case .weekly:
            return Strings.TransactionDetails.weekly
        case .monthly:
            return Strings.TransactionDetails.monthly
        case .quarterly:
            return Strings.TransactionDetails.quarterly
        case .yearly:
            return Strings.TransactionDetails.yearly
        case .unknown:
            return Strings.TransactionDetails.notIdentified
        }
    }
}

struct SubscriptionPaymentHistoryModel: Identifiable, Codable, Equatable {
    let id: UUID
    let date: Date
    let amount: Decimal
    let currencyCode: String
    let status: TransactionStatus
}

struct PaymentMethodSummaryModel: Identifiable, Codable, Equatable {
    let id: UUID
    let title: String
    let subtitle: String?
    let lastFourDigits: String?
    let icon: String

    var displayTitle: String {
        guard let lastFourDigits else { return title }
        return "\(title) **** \(lastFourDigits)"
    }
}

struct RefundDetailsModel: Codable, Equatable {
    let originalTransactionId: UUID
    let originalMerchantName: String
    let originalPurchaseDate: Date
    let refundReason: String?
    let expectedAvailabilityDate: Date?
}

struct InvoicePaymentDetailsModel: Codable, Equatable {
    let invoiceId: UUID
    let cardId: UUID
    let cardName: String
    let billingPeriod: String
    let paidAmount: Decimal
    let currencyCode: String
    let paymentMethod: PaymentMethodSummaryModel
    let confirmationCode: String
}
