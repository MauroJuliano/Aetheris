import SwiftUI
import AetherisDesignSystem

public struct Beneficiary: Identifiable {
    public var id: UUID
    var name: String
    var pixKey: String
    var image: String
    var hasDivider: Bool
    
    public init(id: UUID = UUID(),
                name: String,
                pixKey: String,
                image: String,
                hasDivider: Bool) {
        self.id = id
        self.name = name
        self.pixKey = pixKey
        self.image = image
        self.hasDivider = hasDivider
    }
    
    public static let beneficiaries: [Beneficiary] = [
        Beneficiary(name: "Melissa", pixKey: "contact@melissamccarthy.com", image: "melissa", hasDivider: true),
        Beneficiary(name: "Ed sheeran", pixKey: "afirelove", image: "ed", hasDivider: true),
        Beneficiary(name: "Adele", pixKey: "rollinginthedeep", image: "Adele", hasDivider: true),
        Beneficiary(name: "Troy Bolton", pixKey: "scream", image: "Troy", hasDivider: false)
    ]
}

public struct BeneficiaryCell: View {
    @State var model: Beneficiary
    var onChange: ((Beneficiary) -> Void)? = nil
    
    public init(model: Beneficiary,
                onChange: ((Beneficiary) -> Void)? = nil) {
        self.model = model
        self.onChange = onChange
    }
    
    public var body: some View {
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
