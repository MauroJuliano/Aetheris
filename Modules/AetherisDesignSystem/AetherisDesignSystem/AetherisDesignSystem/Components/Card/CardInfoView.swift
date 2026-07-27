import SwiftUI

struct CardInfoView: View {
    @State var infoModel: InfoCardModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: AppRadius.medium)
                .fill(infoModel.color)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(infoModel.headline)
                        .foregroundStyle(.white)
                        .font(AppFont.roboto(.regular, size: 16))
                    
                    Spacer()
                    
                    HStack() {
                        if let title = infoModel.title {
                            Text(title)
                                .foregroundStyle(.white)
                                .font(AppFont.roboto(.bold, size: 20))
                        }
                        
                        Spacer()
                        
                        if let icon = infoModel.icon {
                            Image(systemName: icon)
                                .font(.system(size: 40))
                                .foregroundStyle(.white)
                        }
                    }
                    
                    if let caption = infoModel.caption {
                        Text(caption)
                            .foregroundStyle(.white)
                            .font(AppTypography.cardBody)
                    }
                    
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: AppRadius.pill)
                            .fill(.white)
                            .frame(width: AppCardMetrics.infoCardButtonSize.width, height: AppCardMetrics.infoCardButtonSize.height)
                        
                        Text(infoModel.button)
                            .foregroundStyle(Color.textPrimary)
                            .font(AppTypography.button)
                    }
                    .appShadow(AppShadow.elevated)
                }
                .padding(AppSpacing.medium)
                
                Spacer()
            }
            }
            .frame(width: AppCardMetrics.infoCardSize.width, height: AppCardMetrics.infoCardSize.height)
            .appShadow(AppShadow.elevated)
        }
}

