import SwiftUI

public enum SpectrumRatio {
    case horizontal
    case vertical
    
    var size: CGSize {
        switch self {
        case .horizontal:
            return CGSize(width: 160, height: 116)
        case .vertical:
            return CGSize(width: 160, height: 240)
        }
    }
}

public struct CardDistributionModel {
    var title: String
    var subTitle: String
    var icon: String
    
    public init(title: String,
                subTitle: String,
                icon: String) {
        self.title = title
        self.subTitle = subTitle
        self.icon = icon
    }
    
    public static let mockCreditCard: CardDistributionModel = .init(title: "Credit Card", subTitle: "Enjoy exclusive benefits with zero annual fee.", icon: "creditcard")
    public static let mockLoans: CardDistributionModel = .init(title: "Loan",
                                                        subTitle: "Apply today and receive funds within 24 hours",
                                                        icon: "chart.line.uptrend.xyaxis")
    public static let mockInvestiment: CardDistributionModel = .init(title: "Investments",
                                                              subTitle: "Grow your money with expert-curated portfolios",
                                                              icon: "shield.fill")
}

public struct CardDistribution: View {
    @State var primaryColor: Color
    @State var backgroundColor: Color?
    @State var backgroundImage: String?
    @State var spectrumRatio: SpectrumRatio
    @State var hasButton: Bool = false
    @State var model: CardDistributionModel
    
    public init(primaryColor: Color,
                backgroundColor: Color? = nil,
                backgroundImage: String? = nil,
                spectrumRatio: SpectrumRatio,
                hasButton: Bool = false,
                model: CardDistributionModel) {
        self.primaryColor = primaryColor
        self.backgroundColor = backgroundColor
        self.backgroundImage = backgroundImage
        self.spectrumRatio = spectrumRatio
        self.hasButton = hasButton
        self.model = model
    }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(backgroundColor ?? .black)
            
            VStack() {
                Spacer()
                
                HStack {
                    Image(systemName: model.icon)
                        .resizable()
                        .foregroundColor(primaryColor)
                        .frame(width: 24, height: 24)
                        
                    
                    Spacer()
                }
                
                Spacer()
                
                HStack() {
                    Text(model.title)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(.white)
                        .font(AppFont.roboto(.bold, size: 16))
                        .foregroundStyle(primaryColor)
                    
                    
                    Spacer()
                }
                Spacer()
            }
            .padding(8)
        }
        .frame(width: spectrumRatio.size.width, height: spectrumRatio.size.height)
        .shadow(color: .black.opacity(0.3),radius: 10, x: 0, y: 5)
    }
}

#Preview {
    CardDistribution(primaryColor: .white,
                     backgroundColor: .primary,
                     spectrumRatio: .horizontal,
                     hasButton: true,
                     model: .mockInvestiment)
}
