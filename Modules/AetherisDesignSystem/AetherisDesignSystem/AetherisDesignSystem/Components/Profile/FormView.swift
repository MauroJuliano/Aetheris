import SwiftUI

public struct FormView: View {
    @State var cells: [FormCellModel]
    let onCellTap: ((FormCellModel) -> Void)?
    
    public init(
        cells: [FormCellModel],
        onCellTap: ((FormCellModel) -> Void)? = nil
    ) {
        self.cells = cells
        self.onCellTap = onCellTap
    }
    
    public var body: some View {
        VStack {
            ForEach(cells) { cell in
                FormCell(model: cell,
                         hasDivider: cell.id != cells.last?.id,
                         onTap: onCellTap == nil ? nil : { onCellTap?(cell) })
                    .padding(AppSpacing.xxSmall)
            }
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }
}

