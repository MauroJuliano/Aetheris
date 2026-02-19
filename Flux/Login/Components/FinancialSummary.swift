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
                .padding(.trailing, 5)
            
            VStack(alignment: .leading) {
                Text(model.title)
                    .foregroundStyle(.black)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text(model.description)
                    .foregroundStyle(.black)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .monospacedDigit()
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text(model.value)
                    .foregroundStyle(.black)
                    .font(.headline)
                    .monospacedDigit()
            }
        }
        .padding(.horizontal, 10)
        .frame(minHeight: 30)
        
        Divider()
    }
}

#Preview {
    FinancialSummary(model: .previewMock)
}
