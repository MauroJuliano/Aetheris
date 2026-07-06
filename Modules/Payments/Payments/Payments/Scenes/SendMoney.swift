import AetherisDesignSystem
import SwiftUI

struct SendMoney: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var input = "$ "
    @State private var showSelection = false
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
                       model: .init(firstText: "Transfer", hasInitialSpace: false),
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
                        
                        Text("Continue")
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
        
    }
}

#Preview {
    SendMoney(model: .beneficiaries.first!,
              onBackAction: {
        
    })
}
