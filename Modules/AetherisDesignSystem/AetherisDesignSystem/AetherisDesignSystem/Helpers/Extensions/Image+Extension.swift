import SwiftUI

private final class AetherisDesignSystemImageBundleToken {}

public extension Image {
    static func designSystem(
        _ name: String
    ) -> Image {
        Image(
            name,
            bundle: Bundle(
                for: AetherisDesignSystemImageBundleToken.self
            )
        )
    }
}
