import AetherisDesignSystem
import SwiftUI

struct HomeQuickActions: View {
    var actions: [CardOptions]
    
    var body: some View {
        HStack(spacing: AppSpacing.xLarge) {
            ForEach(actions.prefix(4)) { option in
                let buttonModel = GlassButtonModel(label: option.label,
                                                   icon: option.icon)
                GlassButton(model: buttonModel) {}
                .padding(.vertical)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, AppSpacing.screenHorizontal)
        .appCardSurface()
    }
}
