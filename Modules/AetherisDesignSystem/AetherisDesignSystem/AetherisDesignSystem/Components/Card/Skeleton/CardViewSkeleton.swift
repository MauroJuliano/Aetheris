import SwiftUI

struct CardViewSkeleton: View {
    var body: some View {
        RoundedRectangle(cornerRadius: AppCardMetrics.creditCardBorderRadius)
            .fill(Color.textTertiary.opacity(0.12))
            .frame(width: AppCardMetrics.creditCardSize.width, height: AppCardMetrics.creditCardSize.height)
    }
}

#Preview {
    CardViewSkeleton()
        .padding()
        .appScreenBackground()
}
