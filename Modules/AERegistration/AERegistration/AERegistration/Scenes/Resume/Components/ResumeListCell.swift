import SwiftUI
import AetherisDesignSystem

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
                    .font(AppTypography.cellSubtitle)
                
                Text(model.value)
                    .foregroundStyle(Color.textPrimary)
                    .font(AppTypography.onboardingBody)
            }
            
            Spacer()
            
            Button {
                onChange?(model)
            } label: {
                HStack {
                    Text(Strings.Resume.edit)
                        .font(AppTypography.callout)
                        .foregroundStyle(Color.brandPrimaryColor)
                    
                    Image(systemName: "chevron.forward")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color.brandPrimaryColor)
                        .frame(width: 12, height: 12)
                }
            }
        }
        .appListCellRow(hasDivider: hasDivider, dividerLeading: 0, horizontalPadding: 0, verticalPadding: 0)
    }
}

#Preview {
    ResumeListCell(
        model: ResumeListModel(
            image: "person.fill",
            description: "Full name",
            value: "Melissa Mccarthy"
        )
    )
    .padding()
    .appScreenBackground()
}
