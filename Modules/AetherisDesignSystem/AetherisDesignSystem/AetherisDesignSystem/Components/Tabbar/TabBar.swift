import SwiftUI

public struct TabBarItem: Identifiable, Hashable {
    public let id = UUID()
    public let icon: String
    public let label: String

    public init(icon: String, label: String) {
        self.icon = icon
        self.label = label
    }

    public static let defaultItems: [TabBarItem] = [
        .init(icon: "house", label: Strings.TabBar.home),
        .init(icon: "chart.bar", label: Strings.TabBar.cards),
        .init(icon: "person", label: Strings.TabBar.profile)
    ]
}

public struct TabBar: View {
    @Binding var selectedIndex: Int
    private let items: [TabBarItem]
    let tabWidth: CGFloat = AppTabBarMetrics.itemWidth

    public init(
        selectedIndex: Binding<Int>,
        items: [TabBarItem] = TabBarItem.defaultItems
    ) {
        self._selectedIndex = selectedIndex
        self.items = items
    }
    
    public var body: some View {
        HStack(spacing: AppTabBarMetrics.itemSpacing) {
            ZStack {
                // Background
                RoundedRectangle(cornerRadius: AppTabBarMetrics.containerRadius)
                    .fill(Color.surface)
                    .frame(width: AppTabBarMetrics.containerWidth, height: AppTabBarMetrics.containerHeight)
                    .appShadow(AppShadow.tabBar)
                
                // Moving White Capsule
                HStack(spacing: 0) {
                    ForEach(items.indices, id: \.self) { _ in
                        Color.clear
                            .frame(width: tabWidth, height: AppTabBarMetrics.selectedHeight)
                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: AppTabBarMetrics.selectedRadius)
                        .fill(Color.surface)
                        .frame(width: tabWidth, height: AppTabBarMetrics.selectedHeight)
                        .appShadow(AppShadow.control)
                        .offset(x: (CGFloat(selectedIndex) - CGFloat((items.count - 1) / 2)) * tabWidth)
                        .animation(.easeInOut(duration: 0.3), value: selectedIndex)
                )
                
                // Tab Items
                HStack(spacing: 0) {
                    ForEach(items.indices, id: \.self) { index in
                        tabItem(item: items[index], index: index)
                    }
                }
            }
        }
        
    }
    
    @ViewBuilder
    func tabItem(item: TabBarItem, index: Int) -> some View {
        Button(action: {
            selectedIndex = index
        }) {
            HStack(spacing: 4) {
                Image(systemName: item.icon)
                    .foregroundColor(Color.brandPrimaryColor)
                
                if selectedIndex == index {
                    Text(item.label)
                        .font(.caption)
                        .foregroundColor(.brandPrimaryColor)
                }
            }
            .frame(width: tabWidth, height: AppTabBarMetrics.containerHeight)
        }
        .accessibilityIdentifier("tab.\(index)")
        .accessibilityLabel(item.label)
    }
    
}


struct TabBarPreviewWrapper: View {
    @State private var selectedIndex = 0

    var body: some View {
        // removido bind devido a public acho rever info
        TabBar(selectedIndex: $selectedIndex)
    }
}
