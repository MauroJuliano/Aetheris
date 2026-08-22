import SwiftUI

struct TabBarViewSkeleton: View {
    var body: some View {
        TabBarSkeleton(itemsCount: 3)
    }
}

#Preview {
    VStack {
        Spacer()
        TabBarViewSkeleton()
    }
    .appScreenBackground()
}
