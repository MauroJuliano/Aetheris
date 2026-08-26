import SwiftUI

struct SpendingLineChartSkeleton: View {
    var body: some View {
        RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
            .fill(Color.textTertiary.opacity(0.12))
            .frame(height: 72)
            .overlay {
                HStack(alignment: .bottom, spacing: 4) {
                    ForEach(0..<16, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.brandPrimaryColor.opacity(index.isMultiple(of: 3) ? 0.22 : 0.12))
                            .frame(width: 4, height: CGFloat(18 + (index % 5) * 6))
                    }
                }
                .padding(.horizontal, 12)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
    }
}

#Preview {
    SpendingLineChartSkeleton()
        .padding()
        .appCardSurface()
        .padding()
        .appScreenBackground()
}
