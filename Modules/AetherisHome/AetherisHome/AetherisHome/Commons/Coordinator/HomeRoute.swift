import Foundation
import SwiftUI

enum HomeRoute: Hashable {
    case card(initialCardId: UUID? = nil)
    case sendMoney
    case requestMoney
    case beneficiaryDetails(UUID)
    case beneficiaryList
    case addBeneficiary
    case notifications
    case allServices
    case viewReport
}

struct HomeNavigationState {
    var path = NavigationPath()

    var isAtRoot: Bool { path.isEmpty }

    mutating func push(_ route: HomeRoute) {
        path.append(route)
    }

    mutating func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    mutating func replaceCurrent(with route: HomeRoute) {
        if !path.isEmpty {
            path.removeLast()
        }
        path.append(route)
    }

    mutating func reset() {
        path = NavigationPath()
    }

}
