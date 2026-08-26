import SwiftUI

struct TabBarSkeleton: View {
    let itemsCount: Int

    var body: some View {
        HStack(spacing: AppTabBarMetrics.itemSpacing) {
            ZStack {
                RoundedRectangle(cornerRadius: AppTabBarMetrics.containerRadius)
                    .fill(Color.surface)
                    .frame(width: AppTabBarMetrics.containerWidth, height: AppTabBarMetrics.containerHeight)
                    .appShadow(AppShadow.tabBar)

                HStack(spacing: 0) {
                    ForEach(0..<itemsCount, id: \.self) { _ in
                        SkeletonBlock(width: AppTabBarMetrics.itemWidth - 18, height: 18, radius: 9)
                            .frame(width: AppTabBarMetrics.itemWidth, height: AppTabBarMetrics.containerHeight)
                    }
                }
            }
        }
    }
}

#Preview {
    TabBarSkeleton(itemsCount: 3)
        .padding()
        .appScreenBackground()
}
