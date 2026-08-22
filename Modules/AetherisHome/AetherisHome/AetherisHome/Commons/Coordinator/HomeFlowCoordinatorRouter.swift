import AetherisCardsInterface
import Foundation

enum HomeFlowCoordinatorCommand: Equatable {
    case push(HomeRoute)
    case replace(HomeRoute)
    case showCards(selectedCardId: UUID? = nil)
    case clearSelectedBeneficiary
}

enum HomeFlowCoordinatorRouter {
    static func tabBarIsVisible(isAtRoot: Bool) -> Bool {
        isAtRoot
    }

    static func notificationsTapped() -> [HomeFlowCoordinatorCommand] {
        [.push(.notifications)]
    }

    static func allServicesSelected(
        _ route: AllServicesItem.Route
    ) -> [HomeFlowCoordinatorCommand] {
        switch route {
        case .transfer:
            return [
                .clearSelectedBeneficiary,
                .push(.sendMoney)
            ]

        case .beneficiaries:
            return [
                .replace(.beneficiaryList)
            ]

        case .cards:
            return [
                .clearSelectedBeneficiary,
                .showCards()
            ]

        case .notifications:
            return [
                .replace(.notifications)
            ]

        case .reports:
            return [
                .replace(.viewReport)
            ]
        }
    }
}
