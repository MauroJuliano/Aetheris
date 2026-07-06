import SwiftUI

public struct TabBar: View {
    @Binding var selectedIndex: Int
    let tabWidth: CGFloat = AppTabBarMetrics.itemWidth
    
    public var body: some View {
        HStack(spacing: AppTabBarMetrics.itemSpacing) {
            ZStack {
                // Background
                RoundedRectangle(cornerRadius: AppTabBarMetrics.containerRadius)
                    .fill(Color.surface)
                    .frame(width: AppTabBarMetrics.containerWidth, height: AppTabBarMetrics.containerHeight)
                    .appShadow(AppShadow.card)
                
                // Moving White Capsule
                HStack(spacing: 0) {
                    ForEach(0..<3) { index in
                        Color.clear
                            .frame(width: tabWidth, height: AppTabBarMetrics.selectedHeight)
                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: AppTabBarMetrics.selectedRadius)
                        .fill(Color.surface)
                        .frame(width: tabWidth, height: AppTabBarMetrics.selectedHeight)
                        .appShadow(AppShadow.card)
                        .offset(x: CGFloat(selectedIndex - 1) * tabWidth)
                        .animation(.easeInOut(duration: 0.3), value: selectedIndex)
                )
                
                // Tab Items
                HStack(spacing: 0) {
                    tabItem(icon: "house", label: "Home", index: 0)
                    tabItem(icon: "chart.bar", label: "Cards", index: 1)
                    tabItem(icon: "person", label: "Profile", index: 2)
                }
            }
        }
        
    }
    
    @ViewBuilder
    func tabItem(icon: String, label: String, index: Int) -> some View {
        Button(action: {
            selectedIndex = index
        }) {
            HStack(spacing: AppTabBarMetrics.itemLabelSpacing) {
                Image(systemName: icon)
                    .foregroundColor(Color.brandPrimaryColor)
                
                if selectedIndex == index {
                    Text(label)
                        .font(AppTypography.caption)
                        .foregroundColor(.brandPrimaryColor)
                }
            }
            .frame(width: tabWidth, height: AppTabBarMetrics.containerHeight)
        }
    }
    
}

#Preview {
    TabBarPreviewWrapper()
}

struct TabBarPreviewWrapper: View {
    @State private var selectedIndex = 0

    var body: some View {
        // removido bind devido a public acho rever info
        TabBar(selectedIndex: $selectedIndex)
    }
}
