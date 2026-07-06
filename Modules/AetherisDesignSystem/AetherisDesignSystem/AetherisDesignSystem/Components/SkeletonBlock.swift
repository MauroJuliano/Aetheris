import SwiftUI

public struct SkeletonBlock: View {
    private let width: CGFloat?
    private let height: CGFloat
    private let radius: CGFloat

    public init(width: CGFloat? = nil, height: CGFloat, radius: CGFloat) {
        self.width = width
        self.height = height
        self.radius = radius
    }

    public var body: some View {
        SkeletonView(.rect)
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
    }
}
