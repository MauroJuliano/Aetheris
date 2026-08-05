import AetherisHomeInterface
import Core
import SwiftUI

public final class HomeFactory: HomeFactoryInterface {
    private let coreService: any HasCoreService
    public init(coreService: any HasCoreService) { self.coreService = coreService }

    @MainActor public func make() -> AnyView {
        AnyView(HomeFlowCoordinator(
            coreService: coreService
        ))
    }
}
