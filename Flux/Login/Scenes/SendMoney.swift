import SwiftUI

struct SendMoney: View {
    @State private var input = "$ "
    @State private var showSelection = false
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    
                    NavBar(model: .init(firstText: "Transfer",
                                        hasInitialSpace: false))
                        .padding()
                    
                    TransferBeneficiary(shouldChange: $showSelection)
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
            .padding(.horizontal)
            .background(Color.backgroundColorA)
        }
        .navigationDestination(isPresented: $showSelection) {
            BeneficiaryList(model: Beneficiary.beneficiaries)
//            SelectionView(items: items) { item in
//                // closure returns selected item
//                selectedItem = item
//                showSelection = false // close selection view
//            }
        }
        
    }
}

#Preview {
    SendMoney()
}
