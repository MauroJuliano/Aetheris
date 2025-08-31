import SwiftUI

struct FinancialSummaryModel: Identifiable {
    var id: UUID = UUID()
    var image: String
    var title: String
    var description: String
    var value: String
    
    
    
    static let previewMock: FinancialSummaryModel = .init(image: "melissa",
                                                          title: "Transfer sent",
                                                          description: "Funds successfully transferred to Melissa",
                                                          value: "$ 250.00")
}


struct FinancialSummary: View {
    var model: FinancialSummaryModel
    
    var body: some View {
        HStack {
            Image(model.image)
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(.circle)
                .shadow(color: .black.opacity(0.3),radius: 10, x: 0, y: 5)
            
            VStack(alignment: .leading) {
                Text(model.title)
                    .foregroundStyle(.black)
                    .font(AppFont.roboto(.semibold, size: 20))
                
                Text(model.description)
                    .foregroundStyle(.black)
                    .font(AppFont.roboto(.regular, size: 12))
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text(model.value)
                    .foregroundStyle(.black)
                    .font(AppFont.roboto(.semibold, size: 16))
            }
        }
        .padding(.horizontal, 10)
        .frame(height: 60)
        
        Divider()
    }
}

#Preview {
    FinancialSummary(model: .previewMock)
}
