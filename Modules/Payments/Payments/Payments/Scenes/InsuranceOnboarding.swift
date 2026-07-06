import AetherisDesignSystem
import SwiftUI

struct Benefits: Identifiable {
    let id: UUID = UUID()
    let image: String
    let text: String
    
    static let mock: [Benefits] = [
        Benefits(image: "bolt.circle", text: "Fast and simple digital claims"),
        Benefits(image: "person.2.wave.2", text: "24/7 customer support"),
        Benefits(image: "slider.horizontal.3", text: "Flexible coverage options for any budget"),
        Benefits(image: "rectangle.3.offgrid", text: "Seamless integration with your finance dashboard")
    ]
}

struct benefitsChart: View {
    @State var image: String
    @State var text: String
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: image)
                .resizable()
                .foregroundStyle(Color.textPrimary)
                .frame(width: 20, height: 20)
                .padding(.trailing)
            
            Text(text)
                .multilineTextAlignment(.leading)
                .foregroundStyle(Color.textPrimary)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical)
        
        Divider()
    }
}

struct InsuranceOnboarding: View {
    private let model = Benefits.mock
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Image("melissa")
                    .resizable()
                    .frame(height: 400)
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    Text("Secure your future with our comprehensive financial insurance plan.")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.textPrimary)
                        .multilineTextAlignment(.leading)
                        .frame(maxHeight: .infinity, alignment: .leading)
                        .padding(.top)
                    
                    Text("Benefits:")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.textPrimary)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    ForEach(model) { model in
                        benefitsChart(image: model.image, text: model.text)
                    }
                    .padding(.horizontal)
                }
                .padding(.horizontal)
                
                Button {
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: AppRadius.large)
                            .fill(Color.accentColorBrown)
                            .appShadow(AppShadow.card)
                            .overlay(
                                RoundedRectangle(cornerRadius: AppRadius.pill)
                                    .stroke(Color.border, style: .init(lineWidth: 1))
                            )
                            .frame(width: 300, height: 50)
                        
                        Text("Continue")
                            .foregroundStyle(.white)
                            .font(AppTypography.button)
                    }
                    .padding(AppSpacing.medium)
                }
                
                Button {
                    
                } label: {
                    Text("More options")
                        .font(AppTypography.subheadline)
                        .foregroundStyle(Color.textPrimary)
                }
            }
        }
        .padding(.horizontal, AppSpacing.screenHorizontal)
        .appScreenBackground()
    }
}

#Preview {
    InsuranceOnboarding()
}
