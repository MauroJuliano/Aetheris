import AetherisDesignSystem
import Core
import SwiftUI

struct CurrentInvoiceScreen: View {
    @StateObject private var viewModel: CurrentInvoiceViewModel

    let onBackAction: () -> Void
    let onHelpTap: () -> Void
    let onAvailableLimitTap: () -> Void
    let onBestPurchaseDateTap: () -> Void
    let onSpendingChartsTap: () -> Void
    let onTransactionHistoryTap: (UUID) -> Void
    let onPayInvoiceTap: (UUID) -> Void

    init(
        viewModel: CurrentInvoiceViewModel,
        onBackAction: @escaping () -> Void,
        onHelpTap: @escaping () -> Void = {},
        onAvailableLimitTap: @escaping () -> Void = {},
        onBestPurchaseDateTap: @escaping () -> Void = {},
        onSpendingChartsTap: @escaping () -> Void = {},
        onTransactionHistoryTap: @escaping (UUID) -> Void = { _ in },
        onPayInvoiceTap: @escaping (UUID) -> Void = { _ in }
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onBackAction = onBackAction
        self.onHelpTap = onHelpTap
        self.onAvailableLimitTap = onAvailableLimitTap
        self.onBestPurchaseDateTap = onBestPurchaseDateTap
        self.onSpendingChartsTap = onSpendingChartsTap
        self.onTransactionHistoryTap = onTransactionHistoryTap
        self.onPayInvoiceTap = onPayInvoiceTap
    }

    var body: some View {
        VStack(spacing: 0) {
            navigationBar

            ZStack {
                if let errorMessage = viewModel.errorMessage, !viewModel.isLoading {
                    errorView(message: errorMessage)
                } else if let invoice = viewModel.displayedInvoice {
                    invoiceContent(invoice, isLoading: viewModel.isLoading)
                } else {
                    emptyState
                }
            }
        }
        .appScreenBackground()
        .task {
            await viewModel.loadIfNeeded()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .accessibilityIdentifier("currentInvoice.screen")
    }
}

#Preview {
    CurrentInvoiceScreen(
        viewModel: CurrentInvoiceViewModel(
            cardId: CardsPreviewData.cardId,
            service: CurrentInvoiceService(
                coreService: DemoCoreService(delay: 0)
            )
        ),
        onBackAction: {}
    )
}

private extension CurrentInvoiceScreen {
    var navigationBar: some View {
        NavBar(
            hasNotifications: false,
            hasBackButton: true,
            model: .init(
                firstText: Strings.CurrentInvoice.title,
                hasInitialSpace: false
            ),
            onBack: onBackAction
        )
        .padding(.bottom, AppSpacing.small)
    }

    func invoiceContent(
        _ invoice: CurrentInvoiceModel,
        isLoading: Bool
    ) -> some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: AppSpacing.medium) {
                descriptionText

                CurrentInvoiceOverview(
                    invoice: invoice,
                    onAvailableLimitTap: onAvailableLimitTap,
                    onBestPurchaseDateTap: onBestPurchaseDateTap
                )
                .toSkeleton(enable: isLoading)

                if viewModel.isInvoiceNoticeVisible {
                    CurrentInvoiceNotice {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            viewModel.dismissInvoiceNotice()
                        }
                    }
                    .toSkeleton(enable: isLoading)
                }

                CurrentInvoiceDetails(details: invoice.details)
                    .toSkeleton(enable: isLoading)

                CurrentInvoiceSpendingSummary(
                    summary: invoice.spendingSummary,
                    onChartsTap: onSpendingChartsTap
                )
                .toSkeleton(enable: isLoading)

                summariesSection(isLoading: isLoading)
            }
            .padding(.horizontal, AppSpacing.screenHorizontal)
            .padding(.bottom, AppSpacing.large)
        }
        .safeAreaInset(edge: .bottom) {
            payInvoiceButton(invoice, isLoading: isLoading)
                .padding(.horizontal, AppSpacing.screenHorizontal)
                .padding(.top, AppSpacing.small)
                .padding(.bottom, AppSpacing.small)
                .background(Color.backgroundColorA)
        }
    }

    var descriptionText: some View {
        Text(Strings.CurrentInvoice.description)
            .font(AppTypography.body)
            .foregroundStyle(Color.textSecondaryColor)
            .multilineTextAlignment(.center)
            .padding(.horizontal, AppSpacing.large)
            .padding(.bottom, AppSpacing.xSmall)
    }

    @ViewBuilder
    func summariesSection(isLoading: Bool) -> some View {
        if !viewModel.summaries.isEmpty {
            FinancialSummaryContainer(
                summaries: viewModel.summaries,
                title: Strings.VirtualCard.recentTransactions,
                actionTitle: Strings.VirtualCard.seeAll,
                onTap: openTransactionHistory,
                onActionTap: openTransactionHistory
            )
            .toSkeleton(enable: isLoading)
        }
    }

    func payInvoiceButton(
        _ invoice: CurrentInvoiceModel,
        isLoading: Bool
    ) -> some View {
        PrimaryButton(title: Strings.CurrentInvoice.payInvoice) {
            guard invoice.canBePaid, !viewModel.isStartingPayment else { return }
            onPayInvoiceTap(invoice.id)
        }
        .toSkeleton(enable: isLoading)
        .disabled(viewModel.isStartingPayment || !invoice.canBePaid)
        .opacity(invoice.canBePaid ? 1 : 0.5)
        .accessibilityIdentifier("currentInvoice.payButton")
    }

    func openTransactionHistory() {
        guard let invoiceId = viewModel.invoice?.id else { return }
        onTransactionHistoryTap(invoiceId)
    }

    func errorView(message: String) -> some View {
        FeedbackView(
            title: Strings.CurrentInvoice.unavailableTitle,
            description: message,
            primaryButtonTitle: Strings.Common.tryAgain,
            onPrimaryAction: {
                Task {
                    await viewModel.load()
                }
            }
        )
    }

    var emptyState: some View {
        AppEmptyStateView(
            title: Strings.CurrentInvoice.emptyTitle,
            description: Strings.CurrentInvoice.emptyDescription,
            symbolName: "doc.text"
        )
    }
}
