import SwiftUI

public struct TabBarView: View {
    @Binding var selectedIndex: Int
    var onCenterTap: () -> Void
    
    public init(
        selectedIndex: Binding<Int>,
        onCenterTap: @escaping () -> Void
    ) {
        self._selectedIndex = selectedIndex
        self.onCenterTap = onCenterTap
    }
    
    public var body: some View {
            ZStack(alignment: .bottom) {
                HStack(spacing: AppTabBarMetrics.itemSpacing) {
                    TabBar(selectedIndex: $selectedIndex)
                        .appShadow(AppShadow.tabBar)
                    
                    Button {
                        onCenterTap()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: AppTabBarMetrics.containerRadius)
                                .fill(Color.surface)
                                .frame(width: AppTabBarMetrics.centerButtonSize, height: AppTabBarMetrics.centerButtonSize)

                            Image(systemName: "paperplane")
                                .foregroundColor(Color.brandPrimaryColor)
                        }
                    }
                    .appShadow(AppShadow.tabBar)
                }
                .padding(.horizontal, AppTabBarMetrics.horizontalPadding)
                .padding(.bottom, AppTabBarMetrics.bottomPadding)
            }
    }
}

#Preview {
    TabBarView(selectedIndex: .constant(0), onCenterTap: {
        print("preview")
    })
}
