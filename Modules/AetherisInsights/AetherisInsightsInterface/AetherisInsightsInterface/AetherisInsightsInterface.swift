import Core
import SwiftUI

@MainActor
public protocol HasInsights {
    var insightsFactory: InsightsFactoryInterface { get }
}

@MainActor
public protocol InsightsFactoryInterface {
    func makeReport(
        onBack: @escaping () -> Void
    ) -> AnyView
}
