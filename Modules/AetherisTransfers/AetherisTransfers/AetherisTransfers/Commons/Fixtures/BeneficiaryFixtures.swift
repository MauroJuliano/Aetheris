import AetherisTransfersInterface
import Foundation

public enum BeneficiaryFixtures {
    public static let defaults: [Beneficiary] = [
        .init(
            name: "Sophie Keller",
            pixKey: "sophie.keller@aetheris.app",
            image: "sophie",
            hasDivider: true
        ),
        .init(
            name: "Amelia Thompson",
            pixKey: "amelia.thompson@aetheris.app",
            image: "Amelia",
            hasDivider: true
        ),
        .init(
            name: "Léa Tremblay",
            pixKey: "lea.tremblay@aetheris.app",
            image: "lea",
            hasDivider: true
        ),
        .init(
            name: "Maya Patel",
            pixKey: "maya.patel@aetheris.app",
            image: "maya",
            hasDivider: true
        ),
        .init(
            name: "Hannah Schneider",
            pixKey: "hannah.schneider@aetheris.app",
            image: "hanna",
            hasDivider: true
        ),
        .init(
            name: "Carlos Barbosa",
            pixKey: "carlos.barbosa@aetheris.app",
            image: "aria",
            hasDivider: false
        )
    ]

    public static var defaultSelection: Beneficiary {
        defaults.last ?? .init(
            name: "Carlos Barbosa",
            pixKey: "carlos.barbosa@aetheris.app",
            image: "aria",
            hasDivider: true
        )
    }
}
