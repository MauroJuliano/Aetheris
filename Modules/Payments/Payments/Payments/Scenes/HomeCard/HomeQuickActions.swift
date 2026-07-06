import AetherisDesignSystem
import SwiftUI

struct CardOptions: Identifiable {
    let id = UUID()
    let label: String
    let icon: String
    
    static let mock: [CardOptions] = [
        .init(label: "Send", icon: "paperplane.fill"),
        .init(label: "Request", icon: "arrow.down"),
        .init(label: "Pay", icon: "creditcard.fill"),
        .init(label: "Top up", icon: "plus")
    ]
}

struct HomeQuickActions: View {
    var actions: [CardOptions]
    
    var body: some View {
        HStack(spacing: AppSpacing.xLarge) {
            ForEach(actions.prefix(4)) { option in
                let buttonModel = GlassButtonModel(label: option.label,
                                                   icon: option.icon)
                GlassButton(model: buttonModel) {
                    print("tapped")
                }
                .padding(.vertical)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, AppSpacing.screenHorizontal)
        .appCardSurface()
    }
}

#Preview {
    HomeQuickActions(actions: CardOptions.mock)
}
