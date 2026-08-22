import SwiftUI

struct CardSwipeSkeleton: View {
    var body: some View {
        ZStack {
            CardViewSkeleton()
                .offset(x: 8, y: -6)
                .rotationEffect(.degrees(3))
                .opacity(0.45)

            CardViewSkeleton()
        }
        .frame(width: AppCardMetrics.swipeCardSize.width, height: AppCardMetrics.swipeCardSize.height + 26)
    }
}

#Preview {
    CardSwipeSkeleton()
        .padding()
        .appScreenBackground()
}
