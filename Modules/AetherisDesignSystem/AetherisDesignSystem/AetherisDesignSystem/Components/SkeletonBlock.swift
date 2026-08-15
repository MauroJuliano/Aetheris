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

#Preview {
    VStack(alignment: .leading, spacing: AppSpacing.medium) {
        SkeletonBlock(width: 180, height: 18, radius: 9)
        SkeletonBlock(height: 120, radius: AppRadius.large)
        SkeletonView(.circle)
            .frame(width: 58, height: 58)
    }
    .padding()
    .appScreenBackground()
}
