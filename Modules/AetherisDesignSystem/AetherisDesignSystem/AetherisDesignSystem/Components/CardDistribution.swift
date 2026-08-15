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
    
    public static let sampleCreditCard: CardDistributionModel = .init(title: Strings.CardDistribution.creditCardTitle, subTitle: Strings.CardDistribution.creditCardSubtitle, icon: "creditcard")
    public static let sampleLoans: CardDistributionModel = .init(title: Strings.CardDistribution.loanTitle,
                                                                  subTitle: Strings.CardDistribution.loanSubtitle,
                                                                  icon: "chart.line.uptrend.xyaxis")
    public static let sampleInvestments: CardDistributionModel = .init(title: Strings.CardDistribution.investmentsTitle,
                                                                       subTitle: Strings.CardDistribution.investmentsSubtitle,
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
            RoundedRectangle(cornerRadius: AppRadius.large)
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
                        .font(AppTypography.button)
                        .foregroundStyle(primaryColor)
                    
                    
                    Spacer()
                }
                Spacer()
            }
            .padding(AppSpacing.xSmall)
        }
        .frame(width: spectrumRatio.size.width, height: spectrumRatio.size.height)
        .appShadow(AppShadow.elevated)
    }
}

#Preview {
    HStack(spacing: AppSpacing.medium) {
        CardDistribution(
            primaryColor: .brandPrimaryColor,
            backgroundColor: .black,
            spectrumRatio: .horizontal,
            model: .sampleCreditCard
        )

        CardDistribution(
            primaryColor: .brandSecondaryColor,
            backgroundColor: .textPrimary,
            spectrumRatio: .vertical,
            model: .sampleInvestments
        )
    }
    .padding()
    .appScreenBackground()
}
