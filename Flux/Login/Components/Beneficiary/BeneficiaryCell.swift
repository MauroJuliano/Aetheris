import SwiftUI

struct Beneficiary: Identifiable {
    var id: UUID = UUID()
    var name: String
    var pixKey: String
    var image: String
    var hasDivider: Bool
    
    static let beneficiaries: [Beneficiary] = [
        Beneficiary(name: "Melissa", pixKey: "contact@melissamccarthy.com", image: "melissa", hasDivider: true),
        Beneficiary(name: "Ed sheeran", pixKey: "afirelove", image: "ed", hasDivider: true),
        Beneficiary(name: "Adele", pixKey: "rollinginthedeep", image: "Adele", hasDivider: true),
        Beneficiary(name: "Troy Bolton", pixKey: "scream", image: "Troy", hasDivider: false)
    ]
}

struct BeneficiaryCell: View {
    @State var model: Beneficiary
    var onChange: ((Beneficiary) -> Void)? = nil
    
    var body: some View {
        HStack {
            Image(model.image)
                .resizable()
                .scaledToFill()
                .foregroundStyle(.black)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .aspectRatio(contentMode: .fit)
                .shadow(color: .gray.opacity(0.2), radius: 10, y: 5)
                .padding()
            
            Text(model.name)
                .foregroundStyle(.black)
                .font(AppFont.roboto(.semibold, size: 20))
            
            Spacer()
            
                Button {
                    onChange?(model)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.backgroundColorA)
                            .frame(width: 80, height: 40)
                            .shadow(color: .gray.opacity(0.2), radius: 10, y: 5)
                        
                        Text("Change")
                            .font(AppFont.roboto(.regular, size: 16))
                            .foregroundStyle(Color.accentColorBrown)
                    }
                }
        }
        
        if model.hasDivider {
            Divider()
        }
    }
}

#Preview {
    BeneficiaryCell(model: .init(name: "melissa", pixKey: "melissa", image: "melissa", hasDivider: true))
}
