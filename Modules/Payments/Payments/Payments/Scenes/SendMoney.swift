import AetherisDesignSystem
import SwiftUI

struct SendMoney: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var input = "$ "
    @State private var showSelection = false
    @State var model: Beneficiary = .beneficiaries.first!
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
                VStack {
                    NavBar(hasBackButton: true,
                           model: .init(firstText: "Transfer", hasInitialSpace: false),
                           onBack: {
                        if let onBackAction {
                            onBackAction()
                        } else {
                            dismiss()
                        }
                    })
                    .padding(.horizontal)
                    
                    TransferBeneficiary(shouldChange: $showSelection,
                                        model: $model)
                    .padding()
                    
                    Spacer()
                        .frame(height: 50)
                    
                    NumericKeyboard(text: $input)
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
                                .foregroundStyle(Color.accentColorBrown)
                                .font(AppFont.roboto(.semibold, size: 16))
                                .shadow(color: .black.opacity(0.2), radius: 10, y: 5)
                        }
                    }
                    .padding()
                }
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
