import SwiftUI
import AetherisDesignSystem

public struct TransferBeneficiary: View {
    @Binding var shouldChange: Bool
    @Binding var model: Beneficiary
    
    public init(shouldChange: Binding<Bool>,
                model: Binding<Beneficiary>) {
        self._shouldChange = shouldChange
        self._model = model
    }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.background)
                .shadow(color: .gray.opacity(0.2), radius: 16, y: 5)
            
            
            HStack {
                Image(model.image)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 50, height: 50)
                    .shadow(color: .gray.opacity(0.2), radius: 16, y: 5)
                
                VStack(alignment: .leading) {
                    Text(model.name)
                        .font(AppFont.roboto(.semibold, size: 16))
                        .foregroundStyle(.black)
                    
                    Text(model.pixKey)
                        .font(AppFont.roboto(.regular, size: 14))
                        .foregroundStyle(.gray)
                }
                
                Spacer()
                
                Button {
                    shouldChange = true
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.backgroundColorA)
                            .frame(width: 100, height: 50)
                            .shadow(color: .gray.opacity(0.2), radius: 10, y: 5)
                        
                        Text("Change")
                            .font(AppFont.roboto(.regular, size: 16))
                            .foregroundStyle(Color.accentColorBrown)
                    }
                    
                    
                }
            }
            .padding()
        }
        .frame(height: 100)
        .shadow(color: .gray.opacity(0.2), radius: 16, y: 5)
    }
}

#Preview {
    TransferBeneficiary(shouldChange: .constant(true),
                        model: .constant(Beneficiary.beneficiaries.first!))
}
