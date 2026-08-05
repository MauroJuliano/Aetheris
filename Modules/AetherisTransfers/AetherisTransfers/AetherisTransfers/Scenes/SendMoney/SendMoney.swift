import AetherisDesignSystem
import SwiftUI

struct SendMoney: View {
    @StateObject private var viewModel: SendMoneyViewModel
    @StateObject private var amountViewModel: TransferAmountViewModel
    @Binding private var selectedBeneficiary: Beneficiary
    let onBackAction: (() -> Void)?
    let onChangeBeneficiary: () -> Void
    let onContinue: (TransferDraft) -> Void
    
    init(
        viewModel: SendMoneyViewModel,
        selectedBeneficiary: Binding<Beneficiary>,
        onBackAction: (() -> Void)? = nil,
        onChangeBeneficiary: @escaping () -> Void,
        onContinue: @escaping (TransferDraft) -> Void
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _amountViewModel = StateObject(wrappedValue: TransferAmountViewModel(balance: 1000))
        _selectedBeneficiary = selectedBeneficiary
        self.onBackAction = onBackAction
        self.onChangeBeneficiary = onChangeBeneficiary
        self.onContinue = onContinue
    }
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                SendMoneySkeleton()
            } else if let errorMessage = viewModel.errorMessage {
                FeedbackView(
                    title: Strings.HomeApp.genericErrorTitle,
                    description: errorMessage,
                    primaryButtonTitle: Strings.Common.tryAgain,
                    onPrimaryAction: {
                        Task { await loadSession() }
                    }
                )
            } else {
                content
            }
        }
        .appScreenBackground()
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .task { await loadSession() }
        .accessibilityIdentifier("transfer.amountScreen")
    }

    private var content: some View {
        ScrollView(showsIndicators: false) {
            NavBar(hasBackButton: true,
                   model: .init(firstText: Strings.SendMoney.title, hasInitialSpace: false),
                   onBack: {
                if let onBackAction {
                    onBackAction()
                }
            })

            TransferBeneficiary(
                onChange: onChangeBeneficiary,
                model: $selectedBeneficiary
            )
            .padding()
            .frame(maxWidth: .infinity)

            NumericKeyboard(
                displayedAmount: amountViewModel.formattedAmount,
                displayedBalance: amountViewModel.formattedBalance,
                onKeyPressed: amountViewModel.handleKeyPress
            )
            .padding()
            .frame(maxWidth: .infinity)

            Spacer()

            Button {
                guard let receipt = viewModel.continueTapped(
                    selectedBeneficiary: selectedBeneficiary,
                    currentAmount: amountViewModel.currentAmount,
                    formattedAmount: amountViewModel.formattedAmount
                ) else {
                    return
                }

                onContinue(receipt)
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: AppRadius.large)
                        .fill(Color.backgroundColorA)
                        .appShadow(AppShadow.card)
                        .overlay(
                            RoundedRectangle(cornerRadius: AppRadius.pill)
                                .stroke(Color.border, style: .init(lineWidth: 1))
                        )
                        .frame(width: 300, height: 50)

                    Text(Strings.SendMoney.continueButton)
                        .foregroundStyle(Color.brandPrimaryColor)
                        .font(AppTypography.headline)
                        .appShadow(AppShadow.control)
                }
            }
            .padding(AppSpacing.medium)
            .disabled(!viewModel.canContinue(currentAmount: amountViewModel.currentAmount))
            .opacity(viewModel.canContinue(currentAmount: amountViewModel.currentAmount) ? 1 : 0.55)
            .accessibilityIdentifier("transfer.continue")
        }
        .padding(.horizontal, AppSpacing.screenHorizontal)
    }

    private func loadSession() async {
        await viewModel.load()
        if viewModel.session != nil {
            amountViewModel.updateBalance(viewModel.walletBalance)
        }
    }
}
