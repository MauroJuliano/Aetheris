import Foundation
import AetherisCardsInterface
import Testing
@testable import AetherisHome

@Suite("HomeFlowCoordinatorRouter")
struct HomeFlowCoordinatorRouterTests {
    @Test
    func tabBarVisibility_matchesNavigationRootState() {
        #expect(HomeFlowCoordinatorRouter.tabBarIsVisible(isAtRoot: true))
        #expect(!HomeFlowCoordinatorRouter.tabBarIsVisible(isAtRoot: false))
    }

    @Test
    func notificationsTap_pushesNotificationsRoute() {
        let commands = HomeFlowCoordinatorRouter.notificationsTapped()

        #expect(commands == [.push(.notifications)])
    }

    @Test(arguments: [
        (AllServicesItem.Route.transfer, [
            HomeFlowCoordinatorCommand.clearSelectedBeneficiary,
            .push(.sendMoney)
        ]),
        (.beneficiaries, [
            .replace(.beneficiaryList)
        ]),
        (.cards, [
            .clearSelectedBeneficiary,
            .showCards()
        ]),
        (.notifications, [
            .replace(.notifications)
        ]),
        (.reports, [
            .replace(.viewReport)
        ])
    ])
    func allServicesRoute_mapsToExpectedEffects(
        route: AllServicesItem.Route,
        expectedEffects: [HomeFlowCoordinatorCommand]
    ) {
        #expect(HomeFlowCoordinatorRouter.allServicesSelected(route) == expectedEffects)
    }
}
