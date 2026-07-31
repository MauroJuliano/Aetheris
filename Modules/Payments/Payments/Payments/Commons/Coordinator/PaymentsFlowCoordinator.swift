import Core
import PaymentsInterface
import SwiftUI

enum PaymentsFlowDestination: Equatable {
    case home
    case card
    case sendMoney
    case profile
    case unsupported
}

struct PaymentsFlowCoordinator: View {
    let entryPoint: PaymentsEntryPoint
    let coreService: any HasCoreService
    let profileStore: ProfileStore
    let onFinished: () -> Void

    @State private var selectedBeneficiary: Beneficiary = BeneficiaryFixtures.defaultSelection

    var destination: PaymentsFlowDestination {
        Self.destination(for: entryPoint)
    }

    static func destination(for entryPoint: PaymentsEntryPoint) -> PaymentsFlowDestination {
        switch entryPoint {
        case .home: .home
        case .card: .card
        case .sendMoney: .sendMoney
        case .profile: .profile
        @unknown default: .unsupported
        }
    }

    @ViewBuilder
    var body: some View {
        switch destination {
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
            ProfileFlowCoordinator(
                profileStore: profileStore,
                coreService: coreService
            )
        case .unsupported:
            EmptyView()
        }
    }
}
