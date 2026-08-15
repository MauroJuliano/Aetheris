import Core
import SwiftUI

public enum InsightsFactory {
    @MainActor
    public static func makeReport(
        coreService: any HasCoreService,
        onBack: @escaping () -> Void
    ) -> AnyView {
        AnyView(ViewReportFlowCoordinator(coreService: coreService, onBack: onBack))
    }
}
