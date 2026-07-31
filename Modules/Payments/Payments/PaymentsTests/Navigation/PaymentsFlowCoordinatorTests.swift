import PaymentsInterface
import Testing
@testable import Payments

@MainActor
@Suite("PaymentsFlowCoordinator")
struct PaymentsFlowCoordinatorTests {
    @Test(arguments: [
        (PaymentsEntryPoint.home, PaymentsFlowDestination.home),
        (PaymentsEntryPoint.card, PaymentsFlowDestination.card),
        (PaymentsEntryPoint.sendMoney, PaymentsFlowDestination.sendMoney),
        (PaymentsEntryPoint.profile, PaymentsFlowDestination.profile)
    ])
    func destination_mapsEverySupportedEntryPoint(
        entryPoint: PaymentsEntryPoint,
        expected: PaymentsFlowDestination
    ) {
        let destination = PaymentsFlowCoordinator.destination(for: entryPoint)

        #expect(destination == expected)
    }
}
