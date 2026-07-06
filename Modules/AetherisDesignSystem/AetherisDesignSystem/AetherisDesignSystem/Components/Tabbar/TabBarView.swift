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
                            Image(systemName: "paperplane")
                                .foregroundColor(Color.brandPrimaryColor)
                                .appIconButtonSurface(
                                    radius: AppTabBarMetrics.containerRadius,
                                    shadow: AppShadow.tabBar
                                )
                        }
                    }
                }
                .padding(.horizontal, AppSpacing.screenHorizontal)
                .padding(.bottom, AppSpacing.large)
            }
    }
}

#Preview {
    TabBarView(selectedIndex: .constant(0), onCenterTap: {
        print("preview")
    })
}
