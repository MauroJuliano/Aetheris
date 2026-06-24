import SwiftUI

public struct FormView: View {
    @State var cells: [FormCellModel]
    
    public init(cells: [FormCellModel]) {
        self.cells = cells
    }
    
    public var body: some View {
        VStack {
            ForEach(cells) { cell in
                FormCell(model: cell,
                         hasDivider: cell.id != cells.last?.id)
                    .padding(5)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color.backgroundColorA)
                .shadow(color: .black.opacity(0.08), radius: 24, x: 12, y: 12)
        )
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
