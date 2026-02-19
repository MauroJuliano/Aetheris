import SwiftUI

struct BeneficiaryList: View {
    @Binding var showSelection: Bool
    @State var model: [Beneficiary]
    var onSelect: (Beneficiary) -> Void
    
    var body: some View {
        VStack {
            NavBar(hasBackButton: true,
                   model: .init(firstText: "Beneficiaries", hasInitialSpace: false),
                   onBack: {
                showSelection = false
            })
            
            ScrollView {
                Spacer()
                    .frame(height: 50)
                
                VStack {
                    ForEach(model) { cell in
                        BeneficiaryCell(model: cell,
                                        onChange: { selected in
                            onSelect(selected)
                            showSelection = false
                        })
                            .padding(.horizontal)
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.backgroundColorA)
                        .shadow(color: .gray.opacity(0.25), radius: 16, y: 5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.gray.opacity(0.25), style: .init(lineWidth: 1))
                        )
                )
                
            }
            .background(Color.backgroundColorA)
        }
        .padding(.horizontal)
        .background(Color.backgroundColorA)

    }
}

#Preview {
    BeneficiaryList(showSelection: .constant(true),
                    model: Beneficiary.beneficiaries,
                    onSelect: { selected in
        print(selected)
    })
}
