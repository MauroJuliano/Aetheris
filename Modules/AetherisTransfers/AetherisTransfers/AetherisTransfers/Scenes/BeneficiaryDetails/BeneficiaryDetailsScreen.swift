import AetherisDesignSystem
import AetherisTransfersInterface
import Core
import SwiftUI

struct BeneficiaryDetailsScreen: View {
    @StateObject private var viewModel: BeneficiaryDetailsViewModel
    @State private var isRemoveConfirmationPresented = false

    let onBackAction: () -> Void
    let onNotificationsTap: () -> Void
    let onTransferTap: (Beneficiary) -> Void
    let onRequestMoneyTap: (RequestContactModel) -> Void
    let onMoreOptionsTap: (UUID) -> Void
    let onTransactionTap: (UUID) -> Void
    let onTransactionHistoryTap: (UUID) -> Void
    let onBeneficiaryRemoved: () -> Void

    init(
        viewModel: BeneficiaryDetailsViewModel,
        onBackAction: @escaping () -> Void,
        onNotificationsTap: @escaping () -> Void = {},
        onTransferTap: @escaping (Beneficiary) -> Void = { _ in },
        onRequestMoneyTap: @escaping (RequestContactModel) -> Void = { _ in },
        onMoreOptionsTap: @escaping (UUID) -> Void = { _ in },
        onTransactionTap: @escaping (UUID) -> Void = { _ in },
        onTransactionHistoryTap: @escaping (UUID) -> Void = { _ in },
        onBeneficiaryRemoved: @escaping () -> Void = {}
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onBackAction = onBackAction
        self.onNotificationsTap = onNotificationsTap
        self.onTransferTap = onTransferTap
        self.onRequestMoneyTap = onRequestMoneyTap
        self.onMoreOptionsTap = onMoreOptionsTap
        self.onTransactionTap = onTransactionTap
        self.onTransactionHistoryTap = onTransactionHistoryTap
        self.onBeneficiaryRemoved = onBeneficiaryRemoved
    }

    var body: some View {
        VStack(spacing: 0) {
            navigationBar

            ZStack {
                if viewModel.isLoading {
                    BeneficiaryDetailsSkeleton()
                } else if let errorMessage = viewModel.errorMessage {
                    errorView(message: errorMessage)
                } else if let beneficiary = viewModel.beneficiary {
                    content(beneficiary)
                } else {
                    emptyState
                }
            }
        }
        .appScreenBackground()
        .task {
            await viewModel.loadIfNeeded()
        }
        .confirmationDialog(
            Strings.BeneficiaryDetails.removeConfirmationTitle,
            isPresented: $isRemoveConfirmationPresented,
            titleVisibility: .visible
        ) {
            Button(Strings.BeneficiaryDetails.removeBeneficiary, role: .destructive) {
                removeBeneficiary()
            }

            Button(Strings.Common.cancel, role: .cancel) {}
        } message: {
            Text(Strings.BeneficiaryDetails.removeConfirmationDescription)
        }
        .alert(
            Strings.BeneficiaryDetails.actionErrorTitle,
            isPresented: actionErrorBinding
        ) {
            Button(Strings.Common.ok, role: .cancel) {
                viewModel.dismissActionError()
            }
        } message: {
            if let actionErrorMessage = viewModel.actionErrorMessage {
                Text(actionErrorMessage)
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .accessibilityIdentifier("beneficiaryDetails.screen")
    }
}

private extension BeneficiaryDetailsScreen {
    var navigationBar: some View {
        NavBar(
            hasNotifications: true,
            hasBackButton: true,
            model: .init(
                firstText: Strings.BeneficiaryDetails.title,
                hasInitialSpace: false
            ),
            onBack: onBackAction,
            onRightButtonAction: onNotificationsTap
        )
        .padding(.horizontal, AppSpacing.screenHorizontal)
        .padding(.bottom, AppSpacing.small)
    }

    func content(_ beneficiary: BeneficiaryDetailsModel) -> some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: AppSpacing.medium) {
                BeneficiaryProfileHeader(
                    beneficiary: beneficiary,
                    onTransferTap: {
                        onTransferTap(beneficiary.transferBeneficiary)
                    },
                    onRequestMoneyTap: {
                        onRequestMoneyTap(beneficiary.requestContact)
                    },
                    onMoreOptionsTap: {
                        onMoreOptionsTap(beneficiary.id)
                    }
                )

                BeneficiaryInformationSection(information: beneficiary.information)

                BeneficiaryTransactionsSection(
                    summary: beneficiary.transactionSummary,
                    transactions: beneficiary.recentTransactions,
                    onSeeAllTap: {
                        onTransactionHistoryTap(beneficiary.id)
                    },
                    onTransactionTap: onTransactionTap
                )

                RemoveBeneficiaryButton(
                    isLoading: viewModel.isRemoving,
                    action: {
                        isRemoveConfirmationPresented = true
                    }
                )
            }
            .padding(.horizontal, AppSpacing.screenHorizontal)
            .padding(.bottom, AppSpacing.bottomBarClearance)
        }
    }

    func removeBeneficiary() {
        Task {
            let wasRemoved = await viewModel.removeBeneficiary()
            guard wasRemoved else { return }
            onBeneficiaryRemoved()
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
            title: Strings.BeneficiaryDetails.unavailableTitle,
            description: message,
            primaryButtonTitle: Strings.Common.tryAgain,
            onPrimaryAction: {
                Task { await viewModel.load() }
            }
        )
    }

    var emptyState: some View {
        AppEmptyStateView(
            title: Strings.BeneficiaryDetails.emptyTitle,
            description: Strings.BeneficiaryDetails.emptyDescription
        )
    }
}
