import SwiftUI

public struct TransactionTagModel: Hashable {
    public let title: String
    public let icon: String
    public let color: Color

    public init(title: String, icon: String, color: Color) {
        self.title = title
        self.icon = icon
        self.color = color
    }
}
