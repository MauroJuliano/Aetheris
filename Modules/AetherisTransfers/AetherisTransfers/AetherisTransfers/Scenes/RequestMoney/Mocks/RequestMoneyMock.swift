import Foundation

enum RequestMoneyMock {
    static let contacts: [RequestContactModel] = BeneficiaryFixtures.defaults.map {
        RequestContactModel(
            id: $0.id,
            name: $0.name,
            contactInformation: $0.pixKey,
            imageName: $0.image
        )
    }

    static let amountPresets: [RequestMoneyAmountPresetModel] = [
        RequestMoneyAmountPresetModel(id: "preset_50", value: 50),
        RequestMoneyAmountPresetModel(id: "preset_100", value: 100),
        RequestMoneyAmountPresetModel(id: "preset_150", value: 150),
        RequestMoneyAmountPresetModel(id: "preset_200", value: 200),
        RequestMoneyAmountPresetModel(id: "preset_300", value: 300)
    ]

    static func moneyRequest(for request: RequestMoneyCreateRequest) -> MoneyRequestModel {
        MoneyRequestModel(
            id: UUID(),
            contact: contacts.first { $0.id == request.contactId },
            amount: request.amount,
            reason: request.reason,
            paymentLink: nil,
            createdAt: Date(),
            status: .pending
        )
    }

    static func sharedRequest(for request: SharedMoneyCreateRequest) -> MoneyRequestModel {
        MoneyRequestModel(
            id: UUID(),
            contact: nil,
            amount: request.amount,
            reason: request.reason,
            paymentLink: URL(string: "https://aetheris.app/request/mock"),
            createdAt: Date(),
            status: .pending
        )
    }
}

extension RequestMoneyDashboard {
    static let mock = RequestMoneyDashboard(
        requesterName: "Blake Lehmann",
        recentContacts: RequestMoneyMock.contacts,
        amountPresets: RequestMoneyMock.amountPresets,
        defaultReason: nil
    )
}
