import AetherisDesignSystem
import SwiftUI

struct HomeQuickActions: View {
    let actions: [CardOptions]
    let onAction: (CardOptions) -> Void

    var body: some View {
        HStack(spacing: AppSpacing.xLarge) {
            ForEach(actions.prefix(4)) { option in
                GlassButton(
                    model: GlassButtonModel(
                        label: option.label,
                        icon: option.icon
                    ),
                    action: {
                        onAction(option)
                    }
                )
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, AppSpacing.medium)
        .padding(.horizontal, AppSpacing.small)
        .appCardSurface()
    }
}
