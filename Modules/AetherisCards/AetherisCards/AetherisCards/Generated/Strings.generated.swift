// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Strings {
  internal enum CardHome {
    /// Cards
    internal static let title = Strings.tr("Localizable", "CardHome.title", fallback: "Cards")
  }
  internal enum CardInformation {
    /// Limite disponível
    internal static let availableLimit = Strings.tr("Localizable", "CardInformation.availableLimit", fallback: "Limite disponível")
    /// Fechada
    internal static let closedInvoice = Strings.tr("Localizable", "CardInformation.closedInvoice", fallback: "Fechada")
    /// Fatura atual
    internal static let currentInvoice = Strings.tr("Localizable", "CardInformation.currentInvoice", fallback: "Fatura atual")
    /// Vencimento
    internal static let dueDate = Strings.tr("Localizable", "CardInformation.dueDate", fallback: "Vencimento")
    /// Vence em breve
    internal static let dueSoon = Strings.tr("Localizable", "CardInformation.dueSoon", fallback: "Vence em breve")
    /// Bloquear
    internal static let lock = Strings.tr("Localizable", "CardInformation.lock", fallback: "Bloquear")
    /// Aberta
    internal static let openInvoice = Strings.tr("Localizable", "CardInformation.openInvoice", fallback: "Aberta")
    /// de %@
    internal static func totalLimit(_ p1: Any) -> String {
      return Strings.tr("Localizable", "CardInformation.totalLimit", String(describing: p1), fallback: "de %@")
    }
    /// Desbloquear
    internal static let unlock = Strings.tr("Localizable", "CardInformation.unlock", fallback: "Desbloquear")
    /// Cartão virtual
    internal static let virtualCard = Strings.tr("Localizable", "CardInformation.virtualCard", fallback: "Cartão virtual")
  }
  internal enum Common {
    /// Back
    internal static let back = Strings.tr("Localizable", "Common.back", fallback: "Back")
    /// Try again
    internal static let tryAgain = Strings.tr("Localizable", "Common.tryAgain", fallback: "Try again")
  }
  internal enum CurrentInvoice {
    /// Limite disponível
    internal static let availableLimit = Strings.tr("Localizable", "CurrentInvoice.availableLimit", fallback: "Limite disponível")
    /// Melhor data para compra
    internal static let bestPurchaseDate = Strings.tr("Localizable", "CurrentInvoice.bestPurchaseDate", fallback: "Melhor data para compra")
    /// Fechar aviso
    internal static let closeNotice = Strings.tr("Localizable", "CurrentInvoice.closeNotice", fallback: "Fechar aviso")
    /// %d dias para vencer
    internal static func daysUntilDue(_ p1: Int) -> String {
      return Strings.tr("Localizable", "CurrentInvoice.daysUntilDue", p1, fallback: "%d dias para vencer")
    }
    /// Acompanhe o valor da sua fatura, vencimento e detalhes dos seus gastos do período.
    internal static let description = Strings.tr("Localizable", "CurrentInvoice.description", fallback: "Acompanhe o valor da sua fatura, vencimento e detalhes dos seus gastos do período.")
    /// Detalhes da fatura
    internal static let detailsTitle = Strings.tr("Localizable", "CurrentInvoice.detailsTitle", fallback: "Detalhes da fatura")
    /// Descontos e créditos
    internal static let discountsAndCredits = Strings.tr("Localizable", "CurrentInvoice.discountsAndCredits", fallback: "Descontos e créditos")
    /// Pagamentos e estornos
    internal static let discountsAndCreditsDescription = Strings.tr("Localizable", "CurrentInvoice.discountsAndCreditsDescription", fallback: "Pagamentos e estornos")
    /// Vencimento
    internal static let dueDate = Strings.tr("Localizable", "CurrentInvoice.dueDate", fallback: "Vencimento")
    /// Vence hoje
    internal static let dueToday = Strings.tr("Localizable", "CurrentInvoice.dueToday", fallback: "Vence hoje")
    /// Quando você realizar compras com seu cartão, os lançamentos aparecerão aqui.
    internal static let emptyDescription = Strings.tr("Localizable", "CurrentInvoice.emptyDescription", fallback: "Quando você realizar compras com seu cartão, os lançamentos aparecerão aqui.")
    /// Nenhuma fatura disponível
    internal static let emptyTitle = Strings.tr("Localizable", "CurrentInvoice.emptyTitle", fallback: "Nenhuma fatura disponível")
    /// Parcelado
    internal static let installment = Strings.tr("Localizable", "CurrentInvoice.installment", fallback: "Parcelado")
    /// %d por cento parcelado
    internal static func installmentAccessibilityValue(_ p1: Int) -> String {
      return Strings.tr("Localizable", "CurrentInvoice.installmentAccessibilityValue", p1, fallback: "%d por cento parcelado")
    }
    /// Total da fatura
    internal static let invoiceTotal = Strings.tr("Localizable", "CurrentInvoice.invoiceTotal", fallback: "Total da fatura")
    /// Pagando até o vencimento, você evita juros e mantém seu limite disponível.
    internal static let noticeDescription = Strings.tr("Localizable", "CurrentInvoice.noticeDescription", fallback: "Pagando até o vencimento, você evita juros e mantém seu limite disponível.")
    /// Fatura aberta
    internal static let noticeTitle = Strings.tr("Localizable", "CurrentInvoice.noticeTitle", fallback: "Fatura aberta")
    /// 1 dia para vencer
    internal static let oneDayUntilDue = Strings.tr("Localizable", "CurrentInvoice.oneDayUntilDue", fallback: "1 dia para vencer")
    /// À vista
    internal static let oneTime = Strings.tr("Localizable", "CurrentInvoice.oneTime", fallback: "À vista")
    /// Outros lançamentos
    internal static let otherCharges = Strings.tr("Localizable", "CurrentInvoice.otherCharges", fallback: "Outros lançamentos")
    /// Taxas, tarifas e ajustes
    internal static let otherChargesDescription = Strings.tr("Localizable", "CurrentInvoice.otherChargesDescription", fallback: "Taxas, tarifas e ajustes")
    /// Pagamento em atraso
    internal static let overduePayment = Strings.tr("Localizable", "CurrentInvoice.overduePayment", fallback: "Pagamento em atraso")
    /// Fatura paga
    internal static let paidInvoice = Strings.tr("Localizable", "CurrentInvoice.paidInvoice", fallback: "Fatura paga")
    /// Pagar fatura
    internal static let payInvoice = Strings.tr("Localizable", "CurrentInvoice.payInvoice", fallback: "Pagar fatura")
    /// Subtotal de compras
    internal static let purchasesSubtotal = Strings.tr("Localizable", "CurrentInvoice.purchasesSubtotal", fallback: "Subtotal de compras")
    /// Compras nacionais e internacionais
    internal static let purchasesSubtotalDescription = Strings.tr("Localizable", "CurrentInvoice.purchasesSubtotalDescription", fallback: "Compras nacionais e internacionais")
    /// Ver gráficos
    internal static let seeCharts = Strings.tr("Localizable", "CurrentInvoice.seeCharts", fallback: "Ver gráficos")
    /// Distribuição dos gastos
    internal static let spendingDistribution = Strings.tr("Localizable", "CurrentInvoice.spendingDistribution", fallback: "Distribuição dos gastos")
    /// Resumo de gastos
    internal static let spendingSummaryTitle = Strings.tr("Localizable", "CurrentInvoice.spendingSummaryTitle", fallback: "Resumo de gastos")
    /// Fatura atual
    internal static let title = Strings.tr("Localizable", "CurrentInvoice.title", fallback: "Fatura atual")
    /// Valor total da fatura
    internal static let totalAmount = Strings.tr("Localizable", "CurrentInvoice.totalAmount", fallback: "Valor total da fatura")
    /// Total do limite
    internal static let totalLimit = Strings.tr("Localizable", "CurrentInvoice.totalLimit", fallback: "Total do limite")
    /// Total gasto no período
    internal static let totalSpent = Strings.tr("Localizable", "CurrentInvoice.totalSpent", fallback: "Total gasto no período")
    /// Não foi possível carregar sua fatura
    internal static let unavailableTitle = Strings.tr("Localizable", "CurrentInvoice.unavailableTitle", fallback: "Não foi possível carregar sua fatura")
    /// Limite utilizado
    internal static let usedLimit = Strings.tr("Localizable", "CurrentInvoice.usedLimit", fallback: "Limite utilizado")
    /// %d%% do limite
    internal static func usedLimitPercentage(_ p1: Int) -> String {
      return Strings.tr("Localizable", "CurrentInvoice.usedLimitPercentage", p1, fallback: "%d%% do limite")
    }
    internal enum Status {
      /// Fechada
      internal static let closed = Strings.tr("Localizable", "CurrentInvoice.Status.closed", fallback: "Fechada")
      /// Em aberto
      internal static let `open` = Strings.tr("Localizable", "CurrentInvoice.Status.open", fallback: "Em aberto")
      /// Vencida
      internal static let overdue = Strings.tr("Localizable", "CurrentInvoice.Status.overdue", fallback: "Vencida")
      /// Paga
      internal static let paid = Strings.tr("Localizable", "CurrentInvoice.Status.paid", fallback: "Paga")
    }
  }
  internal enum FinancialSummary {
    /// Apple.Com/Bill
    internal static let appleBill = Strings.tr("Localizable", "FinancialSummary.appleBill", fallback: "Apple.Com/Bill")
    /// %d days ago
    internal static func daysAgo(_ p1: Int) -> String {
      return Strings.tr("Localizable", "FinancialSummary.daysAgo", p1, fallback: "%d days ago")
    }
    /// Ifd* Bar do zé
    internal static let ifoodBar = Strings.tr("Localizable", "FinancialSummary.ifoodBar", fallback: "Ifd* Bar do zé")
    /// %d month ago
    internal static func monthAgo(_ p1: Int) -> String {
      return Strings.tr("Localizable", "FinancialSummary.monthAgo", p1, fallback: "%d month ago")
    }
    /// Netflix
    internal static let netflix = Strings.tr("Localizable", "FinancialSummary.netflix", fallback: "Netflix")
    /// Payment received
    internal static let paymentReceived = Strings.tr("Localizable", "FinancialSummary.paymentReceived", fallback: "Payment received")
    /// Funds received from Ed Sheeran
    internal static let paymentReceivedDescription = Strings.tr("Localizable", "FinancialSummary.paymentReceivedDescription", fallback: "Funds received from Ed Sheeran")
    /// Restaurant
    internal static let restaurant = Strings.tr("Localizable", "FinancialSummary.restaurant", fallback: "Restaurant")
    /// Subscription
    internal static let subscription = Strings.tr("Localizable", "FinancialSummary.subscription", fallback: "Subscription")
    /// Transfer sent
    internal static let transferSent = Strings.tr("Localizable", "FinancialSummary.transferSent", fallback: "Transfer sent")
    /// Funds successfully transferred to Adele
    internal static let transferSentAdeleDescription = Strings.tr("Localizable", "FinancialSummary.transferSentAdeleDescription", fallback: "Funds successfully transferred to Adele")
    /// Funds successfully transferred to Melissa
    internal static let transferSentDescription = Strings.tr("Localizable", "FinancialSummary.transferSentDescription", fallback: "Funds successfully transferred to Melissa")
  }
  internal enum HomeCard {
    /// Cards unavailable
    internal static let cardsUnavailableTitle = Strings.tr("Localizable", "HomeCard.cardsUnavailableTitle", fallback: "Cards unavailable")
    /// This area will reflect the dashboard when the simulated service returns data.
    internal static let emptyDescription = Strings.tr("Localizable", "HomeCard.emptyDescription", fallback: "This area will reflect the dashboard when the simulated service returns data.")
    /// No cards or activity yet
    internal static let emptyTitle = Strings.tr("Localizable", "HomeCard.emptyTitle", fallback: "No cards or activity yet")
  }
  internal enum Notifications {
    /// Last Month
    internal static let sectionLastMonth = Strings.tr("Localizable", "Notifications.sectionLastMonth", fallback: "Last Month")
    /// Last Week
    internal static let sectionLastWeek = Strings.tr("Localizable", "Notifications.sectionLastWeek", fallback: "Last Week")
    /// Others
    internal static let sectionOthers = Strings.tr("Localizable", "Notifications.sectionOthers", fallback: "Others")
    /// Today
    internal static let sectionToday = Strings.tr("Localizable", "Notifications.sectionToday", fallback: "Today")
    /// Yesterday
    internal static let sectionYesterday = Strings.tr("Localizable", "Notifications.sectionYesterday", fallback: "Yesterday")
  }
  internal enum QuickActions {
    /// All services
    internal static let moreSubtitle = Strings.tr("Localizable", "QuickActions.moreSubtitle", fallback: "All services")
    /// More
    internal static let moreTitle = Strings.tr("Localizable", "QuickActions.moreTitle", fallback: "More")
    /// Pay bills
    internal static let paySubtitle = Strings.tr("Localizable", "QuickActions.paySubtitle", fallback: "Pay bills")
    /// Pay
    internal static let payTitle = Strings.tr("Localizable", "QuickActions.payTitle", fallback: "Pay")
    /// Receive money
    internal static let requestSubtitle = Strings.tr("Localizable", "QuickActions.requestSubtitle", fallback: "Receive money")
    /// Request
    internal static let requestTitle = Strings.tr("Localizable", "QuickActions.requestTitle", fallback: "Request")
    /// What would you like to do ?
    internal static let sectionTitle = Strings.tr("Localizable", "QuickActions.sectionTitle", fallback: "What would you like to do ?")
    /// Send
    internal static let sendTitle = Strings.tr("Localizable", "QuickActions.sendTitle", fallback: "Send")
    /// Add funds
    internal static let topUpSubtitle = Strings.tr("Localizable", "QuickActions.topUpSubtitle", fallback: "Add funds")
    /// Top up
    internal static let topUpTitle = Strings.tr("Localizable", "QuickActions.topUpTitle", fallback: "Top up")
    /// Send money
    internal static let transferSubtitle = Strings.tr("Localizable", "QuickActions.transferSubtitle", fallback: "Send money")
    /// Transfer
    internal static let transferTitle = Strings.tr("Localizable", "QuickActions.transferTitle", fallback: "Transfer")
  }
  internal enum TransactionHistory {
    /// This account does not have transaction history in the simulated dataset.
    internal static let emptyDescription = Strings.tr("Localizable", "TransactionHistory.emptyDescription", fallback: "This account does not have transaction history in the simulated dataset.")
    /// No transactions yet
    internal static let emptyTitle = Strings.tr("Localizable", "TransactionHistory.emptyTitle", fallback: "No transactions yet")
    /// Transaction History
    internal static let title = Strings.tr("Localizable", "TransactionHistory.title", fallback: "Transaction History")
    /// History unavailable
    internal static let unavailableTitle = Strings.tr("Localizable", "TransactionHistory.unavailableTitle", fallback: "History unavailable")
  }
  internal enum TransactionsHistory {
    /// Apple
    internal static let apple = Strings.tr("Localizable", "TransactionsHistory.apple", fallback: "Apple")
    /// Deposit
    internal static let deposit = Strings.tr("Localizable", "TransactionsHistory.deposit", fallback: "Deposit")
    /// Melissa
    internal static let melissa = Strings.tr("Localizable", "TransactionsHistory.melissa", fallback: "Melissa")
    /// Netflix
    internal static let netflix = Strings.tr("Localizable", "TransactionsHistory.netflix", fallback: "Netflix")
    /// Payment
    internal static let payment = Strings.tr("Localizable", "TransactionsHistory.payment", fallback: "Payment")
    /// Purchase
    internal static let purchase = Strings.tr("Localizable", "TransactionsHistory.purchase", fallback: "Purchase")
    /// Salary
    internal static let salary = Strings.tr("Localizable", "TransactionsHistory.salary", fallback: "Salary")
    /// Subscription
    internal static let subscription = Strings.tr("Localizable", "TransactionsHistory.subscription", fallback: "Subscription")
    /// Swarovski
    internal static let swarovski = Strings.tr("Localizable", "TransactionsHistory.swarovski", fallback: "Swarovski")
    /// Transactions History
    internal static let title = Strings.tr("Localizable", "TransactionsHistory.title", fallback: "Transactions History")
    /// Transfer received
    internal static let transferReceived = Strings.tr("Localizable", "TransactionsHistory.transferReceived", fallback: "Transfer received")
  }
  internal enum VirtualCard {
    /// Seu cartão está pronto para uso
    internal static let activeDescription = Strings.tr("Localizable", "VirtualCard.activeDescription", fallback: "Seu cartão está pronto para uso")
    /// Cartão virtual ativo
    internal static let activeTitle = Strings.tr("Localizable", "VirtualCard.activeTitle", fallback: "Cartão virtual ativo")
    /// Limite disponível
    internal static let availableLimit = Strings.tr("Localizable", "VirtualCard.availableLimit", fallback: "Limite disponível")
    /// Cancelar
    internal static let cancel = Strings.tr("Localizable", "VirtualCard.cancel", fallback: "Cancelar")
    /// Número copiado
    internal static let copied = Strings.tr("Localizable", "VirtualCard.copied", fallback: "Número copiado")
    /// Copiar número
    internal static let copyNumber = Strings.tr("Localizable", "VirtualCard.copyNumber", fallback: "Copiar número")
    /// Use seu cartão virtual para compras online e assinaturas com mais segurança.
    internal static let description = Strings.tr("Localizable", "VirtualCard.description", fallback: "Use seu cartão virtual para compras online e assinaturas com mais segurança.")
    /// Crie um cartão virtual para realizar compras online com mais segurança.
    internal static let emptyDescription = Strings.tr("Localizable", "VirtualCard.emptyDescription", fallback: "Crie um cartão virtual para realizar compras online com mais segurança.")
    /// Você ainda não possui um cartão virtual
    internal static let emptyTitle = Strings.tr("Localizable", "VirtualCard.emptyTitle", fallback: "Você ainda não possui um cartão virtual")
    /// Gerar novo número
    internal static let generateConfirmationAction = Strings.tr("Localizable", "VirtualCard.generateConfirmationAction", fallback: "Gerar novo número")
    /// O número atual deixará de funcionar. Compras recorrentes e assinaturas poderão precisar ser atualizadas.
    internal static let generateConfirmationMessage = Strings.tr("Localizable", "VirtualCard.generateConfirmationMessage", fallback: "O número atual deixará de funcionar. Compras recorrentes e assinaturas poderão precisar ser atualizadas.")
    /// Gerar novo número?
    internal static let generateConfirmationTitle = Strings.tr("Localizable", "VirtualCard.generateConfirmationTitle", fallback: "Gerar novo número?")
    /// Gerar novo número
    internal static let generateNewNumber = Strings.tr("Localizable", "VirtualCard.generateNewNumber", fallback: "Gerar novo número")
    /// Ative o cartão para voltar a utilizá-lo
    internal static let inactiveDescription = Strings.tr("Localizable", "VirtualCard.inactiveDescription", fallback: "Ative o cartão para voltar a utilizá-lo")
    /// Cartão virtual bloqueado
    internal static let inactiveTitle = Strings.tr("Localizable", "VirtualCard.inactiveTitle", fallback: "Cartão virtual bloqueado")
    /// Saiba mais
    internal static let learnMore = Strings.tr("Localizable", "VirtualCard.learnMore", fallback: "Saiba mais")
    /// Gastos no mês
    internal static let monthlyExpenses = Strings.tr("Localizable", "VirtualCard.monthlyExpenses", fallback: "Gastos no mês")
    /// Transações recentes
    internal static let recentTransactions = Strings.tr("Localizable", "VirtualCard.recentTransactions", fallback: "Transações recentes")
    /// O cartão virtual possui número, validade e CVC diferentes do seu cartão físico.
    internal static let securityDescription = Strings.tr("Localizable", "VirtualCard.securityDescription", fallback: "O cartão virtual possui número, validade e CVC diferentes do seu cartão físico.")
    /// Ver todas
    internal static let seeAll = Strings.tr("Localizable", "VirtualCard.seeAll", fallback: "Ver todas")
    /// Configurações
    internal static let settings = Strings.tr("Localizable", "VirtualCard.settings", fallback: "Configurações")
    /// Cartão virtual
    internal static let title = Strings.tr("Localizable", "VirtualCard.title", fallback: "Cartão virtual")
    /// Cartão virtual indisponível
    internal static let unavailableTitle = Strings.tr("Localizable", "VirtualCard.unavailableTitle", fallback: "Cartão virtual indisponível")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
