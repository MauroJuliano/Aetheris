import SwiftUI

struct FinancialSummaryModel: Identifiable {
    var id: UUID
    var image: String
    var title: String
    var description: String
    var value: String
    
    init(id: UUID = UUID(),
                image: String,
                title: String,
                description: String,
                value: String) {
        self.id = id
        self.image = image
        self.title = title
        self.description = description
        self.value = value
    }
    
    static let previewMock: FinancialSummaryModel = .init(image: "melissa",
                                                                 title: "Transfer sent",
                                                                 description: "Funds successfully transferred to Melissa",
                                                                 value: "$ 250.00")
}

struct FinancialSummary: View {
    var model: FinancialSummaryModel
    var hasDivider: Bool
    
    init(model: FinancialSummaryModel,
                hasDivider: Bool = true) {
        self.model = model
        self.hasDivider = hasDivider
    }
    
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
                    .bold()
                
                Text(model.description)
                    .foregroundStyle(.gray)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .monospacedDigit()
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text(model.value)
                    .foregroundStyle(.black)
                    .bold()
                    .font(.headline)
                    .monospacedDigit()
            }
        }
        .padding()
        
        if hasDivider {
            Divider()
        }
    }
}

#Preview {
    FinancialSummary(model: .previewMock)
}
