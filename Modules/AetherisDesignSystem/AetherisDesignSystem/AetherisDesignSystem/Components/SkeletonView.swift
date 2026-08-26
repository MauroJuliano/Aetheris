import SwiftUI

public struct SkeletonView<S: Shape>: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    let shape: S
    let color: Color
    
    public init(_ shape: S,
                _ color: Color = .gray.opacity(0.3)) {
        self.shape = shape
        self.color = color
    }
    
    @State private var isAnimating: Bool = false
    
    public var body: some View {
        shape
            .fill(color)
            .overlay {
                GeometryReader {
                    let size = $0.size
                    let skeletonWidth = size.width / 2
                    let blurRadius = max(skeletonWidth / 2, 30)
                    let blurDiameter = blurRadius * 2
                    
                    let minX = -(skeletonWidth + blurDiameter)
                    let maxX = size.width + skeletonWidth + blurDiameter
                    
                    Rectangle()
                        .fill(.gray)
                        .frame(width: skeletonWidth, height: size.height * 2)
                        .frame(height: size.height)
                        .blur(radius: blurRadius)
                        .rotationEffect(.init(degrees: rotation))
                        .blendMode(.softLight)
                        .offset(x: isAnimating ? maxX : minX)
                    
                }
            }
            .clipShape(shape)
            .compositingGroup()
            .accessibilityHidden(true)
            .onAppear {
                guard !reduceMotion, !isAnimating else { return }
                withAnimation(animation) {
                    isAnimating = true
                }
            }
            .onDisappear {
                isAnimating = false
            }
            .transaction {
                if $0.animation != animation {
                    $0.animation = .none
                }
            }
    }
    
    var rotation: Double {
        return 5
    }
    
    var animation: Animation {
        .easeInOut(duration: 1.5).repeatForever(autoreverses: false)
    }
}

#Preview {
    SkeletonView(Circle())
        .frame(width: 80, height: 80)
        .padding()
        .appScreenBackground()
}
