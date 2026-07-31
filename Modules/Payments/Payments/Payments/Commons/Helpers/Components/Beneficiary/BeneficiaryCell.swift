import SwiftUI
import AetherisDesignSystem

public struct Beneficiary: Identifiable, Codable, Hashable {
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
        HStack(spacing: AppSpacing.medium - AppSpacing.xxxSmall) {
            Image(model.image)
                .resizable()
                .scaledToFill()
                .frame(width: 46, height: 46)
                .clipShape(Circle())
            
            Text(model.name)
                .font(AppTypography.callout)
                .foregroundStyle(Color.textPrimary)
                .bold()
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
                Button {
                    onChange?(model)
                } label: {
                    Image(systemName: "chevron.forward")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(Color.brandPrimaryColor)
                        .frame(width: 50, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: AppRadius.large)
                                .fill(Color.backgroundColorA)
                        )
                        .appShadow(AppShadow.card)
                }
        }
        .appListCellRow(hasDivider: model.hasDivider)
    }
}
