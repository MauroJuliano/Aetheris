import SwiftUI

struct BeneficiaryList: View {
    @State var model: [Beneficiary]
    var body: some View {
        VStack {
            ForEach(model) { cell in
                BeneficiaryCell(model: cell)
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
        .frame(width: 380)
        .padding()
    }
}

#Preview {
    BeneficiaryList(model: Beneficiary.beneficiaries)
}
