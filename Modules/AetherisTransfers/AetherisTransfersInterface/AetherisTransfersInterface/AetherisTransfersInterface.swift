import Foundation
import SwiftUI

@MainActor public protocol HasTransfers { var transfersFactory: TransfersFactoryInterface { get } }
@MainActor public protocol TransfersFactoryInterface {
    func make(onFinished: @escaping () -> Void) -> AnyView
    func makeRequestMoney(onFinished: @escaping () -> Void) -> AnyView
}

public struct Beneficiary: Identifiable, Codable, Hashable {
    public var id: UUID
    public var name: String
    public var pixKey: String
    public var image: String
    public var hasDivider: Bool

    public init(
        id: UUID = UUID(),
        name: String,
        pixKey: String,
        image: String,
        hasDivider: Bool
    ) {
        self.id = id
        self.name = name
        self.pixKey = pixKey
        self.image = image
        self.hasDivider = hasDivider
    }
}
