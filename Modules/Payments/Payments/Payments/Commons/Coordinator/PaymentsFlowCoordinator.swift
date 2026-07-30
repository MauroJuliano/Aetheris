import Core
import PaymentsInterface
import SwiftUI

struct PaymentsFlowCoordinator: View {
    let entryPoint: PaymentsEntryPoint
    let coreService: any HasCoreService
    let profileStore: ProfileStore
    let onFinished: () -> Void

    @State private var selectedBeneficiary: Beneficiary = .defaultSelection

    var body: some View {
        switch entryPoint {
        case .home:
            HomeFlowCoordinator(
                coreService: coreService,
                selectedBeneficiary: $selectedBeneficiary
            )

        case .card:
            CardFlowCoordinator(
                coreService: coreService,
                onDismiss: onFinished
            )

        case .sendMoney:
            SendMoneyFlowCoordinator(
                coreService: coreService,
                selectedBeneficiary: $selectedBeneficiary,
                onBackAction: onFinished
            )

        case .profile:
            ProfileFlowCoordinator(profileStore: profileStore)
        @unknown default:
            EmptyView()
        }
    }
}
