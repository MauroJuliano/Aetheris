import Core
import AetherisInsightsInterface
import SwiftUI

public enum InsightsFactory {
    @MainActor
    public static func makeReport(
        coreService: any HasCoreService,
        onBack: @escaping () -> Void
    ) -> AnyView {
        AnyView(
            InsightsFeatureFactory(
                coreService: coreService
            ).makeReport(
                onBack: onBack
            )
        )
    }
}
