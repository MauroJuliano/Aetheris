import SwiftUI

@MainActor public protocol HasHome { var homeFactory: HomeFactoryInterface { get } }
@MainActor public protocol HomeFactoryInterface { func make() -> AnyView }
