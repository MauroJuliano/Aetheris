import AetherisInsightsInterface
import Core
import SwiftUI

public final class InsightsFeatureFactory: InsightsFactoryInterface {
    private let coreService: any HasCoreService

    public init(coreService: any HasCoreService) {
        self.coreService = coreService
    }

    @MainActor
    public func makeReport(
        onBack: @escaping () -> Void
    ) -> AnyView {
        AnyView(
            ViewReportFlowCoordinator(
                coreService: coreService,
                onBack: onBack
            )
        )
    }
}
