import AetherisTransfersInterface
import Foundation

public enum BeneficiaryFixtures {
    public static let defaults: [Beneficiary] = [
        .init(
            name: "Melissa",
            pixKey: "contact@melissamccarthy.com",
            image: "melissa",
            hasDivider: true
        ),
        .init(
            name: "Ed Sheeran",
            pixKey: "afirelove",
            image: "ed",
            hasDivider: true
        ),
        .init(
            name: "Adele",
            pixKey: "rollinginthedeep",
            image: "Adele",
            hasDivider: true
        ),
        .init(
            name: "Troy Bolton",
            pixKey: "scream",
            image: "Troy",
            hasDivider: false
        )
    ]

    public static var defaultSelection: Beneficiary {
        defaults.first ?? .init(
            name: "Melissa",
            pixKey: "contact@melissamccarthy.com",
            image: "melissa",
            hasDivider: true
        )
    }
}
