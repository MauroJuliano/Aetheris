import Foundation

enum HomeRoute: Hashable {
    case card
    case transactionHistory(UUID)
    case sendMoney
    case sendMoneyBeneficiaryList
    case sendMoneyPin(TransferReceiptModel)
    case sendMoneyProcessing(TransferReceiptModel)
    case sendMoneySuccess(TransferReceiptModel)
    case beneficiaryList
    case addBeneficiary
    case notifications
    case allServices
    case insurance
    case viewReport
}

struct HomeNavigationState {
    var path: [HomeRoute] = []

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
        path.removeAll()
    }
}
