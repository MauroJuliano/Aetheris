import AetherisDesignSystem
import Core
import SwiftUI

struct TransactionDetailsScreen: View {
    @StateObject private var viewModel: TransactionDetailsViewModel

    let onBackAction: () -> Void
    let onSupportTap: (UUID) -> Void
    let onShareTap: (UUID) -> Void
    let onDownloadTap: (UUID) -> Void
    let onAddNoteTap: (UUID) -> Void
    let onReportIssueTap: (UUID) -> Void
    let onMerchantTap: (UUID) -> Void
    let onPaymentMethodTap: (UUID) -> Void
    let onTransactionHistoryTap: (UUID) -> Void
    let onBlockMerchantTap: (UUID) -> Void

    init(
        viewModel: TransactionDetailsViewModel,
        onBackAction: @escaping () -> Void,
        onSupportTap: @escaping (UUID) -> Void = { _ in },
        onShareTap: @escaping (UUID) -> Void = { _ in },
        onDownloadTap: @escaping (UUID) -> Void = { _ in },
        onAddNoteTap: @escaping (UUID) -> Void = { _ in },
        onReportIssueTap: @escaping (UUID) -> Void = { _ in },
        onMerchantTap: @escaping (UUID) -> Void = { _ in },
        onPaymentMethodTap: @escaping (UUID) -> Void = { _ in },
        onTransactionHistoryTap: @escaping (UUID) -> Void = { _ in },
        onBlockMerchantTap: @escaping (UUID) -> Void = { _ in }
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onBackAction = onBackAction
        self.onSupportTap = onSupportTap
        self.onShareTap = onShareTap
        self.onDownloadTap = onDownloadTap
        self.onAddNoteTap = onAddNoteTap
        self.onReportIssueTap = onReportIssueTap
        self.onMerchantTap = onMerchantTap
        self.onPaymentMethodTap = onPaymentMethodTap
        self.onTransactionHistoryTap = onTransactionHistoryTap
        self.onBlockMerchantTap = onBlockMerchantTap
    }

    var body: some View {
        VStack(spacing: 0) {
            navigationBar

            ZStack {
                if viewModel.isLoading {
                    TransactionDetailsSkeleton()
                } else if let errorMessage = viewModel.errorMessage {
                    errorView(message: errorMessage)
                } else if let transaction = viewModel.transaction {
                    content(transaction)
                } else {
                    emptyState
                }
            }
        }
        .appScreenBackground()
        .task {
            await viewModel.loadIfNeeded()
        }
        .alert(
            Strings.TransactionDetails.errorTitle,
            isPresented: actionErrorBinding
        ) {
            Button(Strings.Common.ok, role: .cancel) {
                viewModel.dismissActionError()
            }
        } message: {
            if let message = viewModel.actionErrorMessage {
                Text(message)
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .accessibilityIdentifier("transactionDetails.screen")
    }
}

#Preview {
    TransactionDetailsScreen(
        viewModel: TransactionDetailsViewModel(
            transactionId: TransactionMockIDs.netflixSubscription,
            service: TransactionDetailsService(
                coreService: DemoCoreService(delay: 0)
            )
        ),
        onBackAction: {}
    )
}

private extension TransactionDetailsScreen {
    var navigationBar: some View {
        NavBar(
            hasNotifications: false,
            hasBackButton: true,
            model: .init(
                firstText: Strings.TransactionDetails.title,
                hasInitialSpace: false
            ),
            onBack: onBackAction
        )
        .padding(.horizontal, AppSpacing.screenHorizontal)
        .padding(.bottom, AppSpacing.small)
    }

    func content(_ transaction: TransactionDetailsModel) -> some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: AppSpacing.medium) {
                TransactionDetailsHeader(transaction: transaction)
                TransactionGeneralInformation(transaction: transaction)
                TransactionDetailsSectionFactory.make(
                    transaction: transaction,
                    onMerchantTap: onMerchantTap,
                    onPaymentMethodTap: onPaymentMethodTap,
                    onTransactionHistoryTap: onTransactionHistoryTap,
                    onBlockMerchantTap: onBlockMerchantTap
                )
                TransactionSupportCard {
                    onSupportTap(transaction.id)
                }
                TransactionActions(
                    availableActions: transaction.availableActions,
                    isDownloading: viewModel.isDownloadingReceipt
                ) { action in
                    viewModel.performAction(
                        action,
                        onShareTap: onShareTap,
                        onDownloadTap: onDownloadTap,
                        onAddNoteTap: onAddNoteTap,
                        onReportIssueTap: onReportIssueTap
                    )
                }
            }
            .padding(.horizontal, AppSpacing.screenHorizontal)
            .padding(.bottom, AppSpacing.bottomBarClearance)
        }
    }

    var actionErrorBinding: Binding<Bool> {
        Binding(
            get: { viewModel.actionErrorMessage != nil },
            set: { isPresented in
                if !isPresented {
                    viewModel.dismissActionError()
                }
            }
        )
    }

    func errorView(message: String) -> some View {
        FeedbackView(
            title: Strings.TransactionDetails.unavailableTitle,
            description: message,
            primaryButtonTitle: Strings.Common.tryAgain,
            onPrimaryAction: {
                Task { await viewModel.load() }
            }
        )
    }

    var emptyState: some View {
        AppEmptyStateView(
            title: Strings.TransactionDetails.emptyTitle,
            description: Strings.TransactionDetails.emptyDescription
        )
    }
}
