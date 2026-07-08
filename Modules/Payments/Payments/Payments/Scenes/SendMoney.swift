import AetherisDesignSystem
import SwiftUI

struct SendMoney: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var input = "$ "
    @State private var showSelection = false
    @State private var showPin = false
    @State private var showProcessing = false
    @State private var showSuccess = false
    @State private var successReceipt = TransferReceiptModel.mock
    @State var model: Beneficiary = .beneficiaries.first!
    @StateObject private var viewModel = TransferAmountViewModel(
        balance: 1000
    )
    let onBackAction: (() -> Void)?
    
    init(
        model: Beneficiary = .beneficiaries.first!,
        onBackAction: (() -> Void)? = nil
    ) {
        self._model = State(initialValue: model)
        self.onBackAction = onBackAction
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                NavBar(hasBackButton: true,
                       model: .init(firstText: Strings.SendMoney.title, hasInitialSpace: false),
                       onBack: {
                    if let onBackAction {
                        onBackAction()
                    } else {
                        dismiss()
                    }
                })
                
                TransferBeneficiary(shouldChange: $showSelection,
                                    model: $model)
                .padding()
                
                NumericKeyboard(
                    displayedAmount: viewModel.formattedAmount,
                    displayedBalance: viewModel.formattedBalance,
                    onKeyPressed: viewModel.handleKeyPress
                )
                .padding()
                
                Spacer()
                
                Button {
                    successReceipt = makeReceiptModel()
                    showPin = true
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
            }
            .navigationBarHidden(true)
            .padding(.horizontal, AppSpacing.screenHorizontal)
            .appScreenBackground()
        }
        .navigationDestination(isPresented: $showSelection) {
            BeneficiaryList(showSelection: $showSelection,
                            model: Beneficiary.beneficiaries,
                            onSelect: { selected in
                model = selected
            })
            .navigationBarHidden(true)
        }
        .navigationDestination(isPresented: $showPin) {
            TransferPinFactory.make(
                receipt: successReceipt,
                onBack: {
                    showPin = false
                },
                onValidPin: {
                    showPin = false
                    showProcessing = true
                }
            )
            .navigationBarHidden(true)
        }
        .navigationDestination(isPresented: $showProcessing) {
            TransferProcessingFactory.make(
                receipt: successReceipt,
                onCompleted: {
                    showProcessing = false
                    showSuccess = true
                }
            )
            .navigationBarHidden(true)
        }
        .navigationDestination(isPresented: $showSuccess) {
            TransferSuccessView(
                model: successReceipt,
                onBack: {
                    showSuccess = false
                },
                onDone: {
                    dismiss()
                },
                onNewTransfer: {
                    showSuccess = false
                },
                onCopyReference: { reference in
                    UIPasteboard.general.string = reference
                }
            )
            .navigationBarHidden(true)
        }
        
    }

    private func makeReceiptModel() -> TransferReceiptModel {
        TransferReceiptModel(
            amount: viewModel.formattedAmount,
            recipientName: model.name,
            recipientEmail: model.pixKey,
            accountName: "Main Account",
            accountLastDigits: "1234",
            date: formattedReceiptDate,
            referenceId: receiptReferenceId
        )
    }

    private var formattedReceiptDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy 'at' h:mm a"
        return formatter.string(from: Date())
    }

    private var receiptReferenceId: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd-HHmmss"
        return "TRX\(formatter.string(from: Date()))"
    }
}

#Preview {
    SendMoney(model: .beneficiaries.first!,
              onBackAction: {
        
    })
}
