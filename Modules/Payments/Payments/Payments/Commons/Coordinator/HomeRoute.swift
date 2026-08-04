import Foundation

enum HomeRoute: Hashable {
    case card
    case transactionHistory(UUID)
    case sendMoney
    case sendMoneyBeneficiaryList
    case sendMoneyPin(TransferDraft)
    case sendMoneyProcessing(TransferSubmission)
    case sendMoneySuccess(TransferReceiptModel)
    case beneficiaryList
    case addBeneficiary
    case notifications
    case allServices
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

    mutating func returnToSendMoney() {
        guard let sendMoneyIndex = path.lastIndex(of: .sendMoney) else {
            path = [.sendMoney]
            return
        }
        path.removeSubrange(path.index(after: sendMoneyIndex)..<path.endIndex)
    }
}
