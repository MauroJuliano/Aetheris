import Core
import PaymentsInterface
import SwiftUI

struct PaymentsFlowCoordinator: View {
    let entryPoint: PaymentsEntryPoint
    let coreService: any HasCoreService
    let onFinished: () -> Void

    @State private var selectedBeneficiary: Beneficiary = .beneficiaries.first!

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
                selectedBeneficiary: $selectedBeneficiary,
                onBackAction: onFinished
            )

        case .profile:
            ProfileFlowCoordinator()
        @unknown default:
            EmptyView()
        }
    }
}
