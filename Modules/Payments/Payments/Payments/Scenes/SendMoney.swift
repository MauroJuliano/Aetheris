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
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.backgroundColorA)
                            .shadow(color: .gray.opacity(0.25), radius: 16, y: 5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(.gray.opacity(0.25), style: .init(lineWidth: 1))
                            )
                            .frame(width: 300, height: 50)
                        
                        Text("Continue")
                            .foregroundStyle(Color.brandPrimaryColor)
                            .font(.headline)
                            .shadow(color: .black.opacity(0.2), radius: 10, y: 5)
                    }
                }
                .padding()
            }
            .navigationBarHidden(true)
            .padding(.horizontal)
            .background(Color.backgroundColorA)
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
