import SwiftUI

struct FormViewSkeleton: View {
    let rows: Int

    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<rows, id: \.self) { index in
                FormCellSkeleton(
                    hasSectionTitle: index == 0,
                    hasDivider: index < rows - 1,
                    showsToggle: index >= rows - 2
                )
                .padding(AppSpacing.xxSmall)
            }
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }
}

#Preview {
    FormViewSkeleton(rows: 4)
        .padding()
        .appScreenBackground()
}
