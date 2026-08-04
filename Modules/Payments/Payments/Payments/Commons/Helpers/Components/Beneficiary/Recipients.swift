import AetherisDesignSystem
import SwiftUI

public struct Recipients: View {
    @State private var users: [Beneficiary] = Array(BeneficiaryFixtures.defaults.prefix(4))
    private let onSelect: (Beneficiary) -> Void

    public init(onSelect: @escaping (Beneficiary) -> Void = { _ in }) {
        self.onSelect = onSelect
    }
    
    public var body: some View {
        NavigationStack {
           
            VStack(alignment: .leading) {
                HStack {
                    Text(Strings.Recipients.title)
                        .foregroundStyle(Color.textPrimary)
                        .font(.system(size: 20, weight: .medium))
                    
                    Spacer()
                }
                
                HStack {
                    ForEach(users) { user in
                        Button {
                            onSelect(user)
                        } label: {
                            Image(user.image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(.circle)
                                .frame(width: 50, height: 50)
                                .appShadow(AppShadow.elevated)
                        }
                    }
                }
            }
            .padding(AppSpacing.medium)
        }
    }
}
