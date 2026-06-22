import SwiftUI

public struct FormView: View {
    @State var cells: [FormCellModel]
   
    public init(cells: [FormCellModel]) {
        self.cells = cells
    }
    
    public var body: some View {
        VStack {
            ForEach(cells) { cell in
                FormCell(model: cell)
                    .padding(.horizontal)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.backgroundColorA)
                .shadow(color: .gray.opacity(0.25), radius: 16, y: 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.gray.opacity(0.25), style: .init(lineWidth: 1))
                )
        )
        .frame(width: 380)
        .padding()
    }
}

#Preview {
    let cells: [FormCellModel] = [
        FormCellModel(sectionTitle: "General",
                      content: .init(title: "Melissa Mccarthy",
                                     icon: "person",
                                     hasDivider: true)),
        FormCellModel(sectionTitle: nil,
                                  content: .init(title: "contact@melissamccarthy.com",
                                                 icon: "envelope",
                                                 hasDivider: true)),
        FormCellModel(sectionTitle: nil,
                                  content: .init(title: "(33) 9908-3213",
                                                 icon: "iphone.gen2",
                                                 hasDivider: true)),
        FormCellModel(sectionTitle: nil,
                                  content: .init(title: "Feedback",
                                                 icon: "bubble",
                                                 hasDivider: true))
    ]
    
    FormView(cells: cells)
}
