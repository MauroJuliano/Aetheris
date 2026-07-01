import SwiftUI
import AetherisDesignSystem

struct ResumeListModel: Identifiable {
    let id: UUID
    let image: String
    let description: String
    let value: String
    
    public init(id: UUID = UUID(),
                image: String,
                description: String,
                value: String) {
        self.id = id
        self.image = image
        self.description = description
        self.value = value
    }
    
    static let list: [ResumeListModel] = [
        .init(image: "person.fill", description: "Full Name", value: "Melissa Mccarthy")
    ]
}

struct ResumeListCell: View {
    @State var model: ResumeListModel
    let hasDivider: Bool
    var onChange: ((ResumeListModel) -> Void)? = nil
    
    init(model: ResumeListModel,
         hasDivider: Bool = false,
         onChange: ((ResumeListModel) -> Void)? = nil) {
        self.model = model
        self.hasDivider = hasDivider
        self.onChange = onChange
    }
    
    var body: some View {
        HStack {
            Circle()
                .fill(Color.brandPrimaryColor.opacity(0.12))
                .frame(width: 46, height: 46)
                .overlay {
                    Image(systemName: model.image)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(Color.brandPrimaryColor)
                }
            
            VStack(alignment: .leading) {
                Text(model.description)
                    .foregroundStyle(Color.textTertiary)
                    .font(.subheadline)
                
                Text(model.value)
                    .foregroundStyle(.black)
                    .font(.title3)
            }
            
            Spacer()
            
            Button {
                onChange?(model)
            } label: {
                HStack {
                    Text("Edit")
                        .font(.callout)
                        .foregroundStyle(Color.brandPrimaryColor)
                    
                    Image(systemName: "chevron.forward")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color.brandPrimaryColor)
                        .frame(width: 12, height: 12)
                }
            }
        }
        
        if hasDivider {
            Divider()
        }
    }
}

#Preview {
    ResumeListCell(model: .list.first!, hasDivider: false) { ResumeListModel in
        
    }}
