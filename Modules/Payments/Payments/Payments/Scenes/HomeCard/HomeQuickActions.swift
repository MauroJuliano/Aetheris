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
        HStack(spacing: 24) {
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
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color.backgroundColorA)
                .shadow(color: .black.opacity(0.08), radius: 24, x: 12, y: 12)
        )
    }
}

#Preview {
    HomeQuickActions(actions: CardOptions.mock)
}
