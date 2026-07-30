import Core
import AetherisDesignSystem
import SwiftUI

public struct Recipients: View {
    @State private var users: [Beneficiary] = []
    @State private var shouldPresentTransfer: Bool = false
    @State private var selectedUser: Beneficiary?
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
           
            VStack(alignment: .leading) {
                HStack {
                    Text(Strings.Recipients.title)
                        .foregroundStyle(Color.textPrimary)
                        .font(AppFont.roboto(.medium, size: 20))
                    
                    Spacer()
                }
                
                HStack {
                    ForEach(users) { user in
                        Button {
                            selectedUser = user
                            RecentRecipientsStore.shared.record(user)
                            shouldPresentTransfer = true
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
            .onAppear {
                users = RecentRecipientsStore.shared.beneficiaries()
            }
        }
        .navigationDestination(isPresented: $shouldPresentTransfer) {
            if let user = selectedUser {
                SendMoneyFlowCoordinator(
                    coreService: MockCoreServiceApi(),
                    selectedBeneficiary: .constant(user),
                    onBackAction: {}
                )
            }
        }
    }
}
