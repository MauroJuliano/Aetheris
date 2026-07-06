import SwiftUI

public struct ListCell: View {
    public init() {}
    
    public var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .frame(width: 50, height: 50)
                    .clipShape(.buttonBorder)
                
                Image(systemName: "bag")
                    .resizable()
                    .foregroundStyle(.white)
                    .frame(width: 20, height: 25)
                    
            }
            
            VStack(alignment: .leading) {
                Text("Swarovski")
                    .foregroundStyle(Color.textPrimary)
                
                Text("Payment")
                    .font(AppTypography.caption)
                    .foregroundStyle(Color.textSecondaryColor)
            }
            .padding(.horizontal, AppSpacing.screenHorizontal)
            
            Spacer()
            
            Text("-46.99")
                .foregroundStyle(Color.textSecondaryColor)
                .padding(AppSpacing.medium)
        }
        .padding(.horizontal, AppSpacing.screenHorizontal)
    }
}

#Preview {
    ListCell()
}
