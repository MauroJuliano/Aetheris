import SwiftUI

struct CardInfoView: View {
    @State var infoModel: InfoCardModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
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
                            .font(AppFont.roboto(.regular, size: 16))
                    }
                    
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.white)
                            .frame(width: 325, height: 40)
                        
                        Text(infoModel.button)
                            .foregroundStyle(.black)
                            .font(AppFont.roboto(.semibold, size: 16))
                    }
                    .shadow(color: .black.opacity(0.3),radius: 10, x: 0, y: 5)
                }
                .padding()
                
                Spacer()
            }
        }
        .frame(width: 350, height: 200)
        .shadow(color: .black.opacity(0.3),radius: 10, x: 0, y: 5)
    }
}

#Preview {
    let model = InfoCardModel(headline: "Rewards Available",
                              title: "12,500 points",
                              caption: "Worth $125 in travel",
                              icon: "gift",
                              button: "Redeem",
                              color: .black)
    
    CardInfoView(infoModel: model)
}
