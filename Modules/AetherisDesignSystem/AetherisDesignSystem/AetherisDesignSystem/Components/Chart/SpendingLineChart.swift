import SwiftUI

public struct SpendingLineChart: View {
    public init() {}

    private let points: [SpendingPoint] = [
        .init(day: "1", amount: 220),
        .init(day: "2", amount: 280),
        .init(day: "3", amount: 240),
        .init(day: "4", amount: 210),
        .init(day: "5", amount: 200),
        .init(day: "6", amount: 390),
        .init(day: "7", amount: 330),
        .init(day: "8", amount: 270),
        .init(day: "9", amount: 285),
        .init(day: "10", amount: 215),
        .init(day: "11", amount: 350),
        .init(day: "12", amount: 410),
        .init(day: "13", amount: 250),
        .init(day: "14", amount: 180),
        .init(day: "15", amount: 240),
        .init(day: "16", amount: 340),
        .init(day: "17", amount: 360),
        .init(day: "18", amount: 420.50),
        .init(day: "19", amount: 300),
        .init(day: "20", amount: 330),
        .init(day: "21", amount: 290),
        .init(day: "22", amount: 390),
        .init(day: "23", amount: 520),
        .init(day: "24", amount: 210),
        .init(day: "25", amount: 200),
        .init(day: "26", amount: 315),
        .init(day: "27", amount: 370),
        .init(day: "28", amount: 350),
        .init(day: "29", amount: 260),
        .init(day: "30", amount: 230),
        .init(day: "31", amount: 190),
        .init(day: "32", amount: 315)
    ]

    @State private var selectedIndex: Int = 22

    public var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let path = makePath(in: size)
            let selectedPoint = point(at: selectedIndex, in: size)
            let selectedData = points[selectedIndex]

            ZStack {
                path
                    .stroke(
                        Color.brandPrimaryColor,
                        style: StrokeStyle(
                            lineWidth: 3,
                            lineCap: .round,
                            lineJoin: .round
                        )
                    )

                path
                    .stroke(Color.brandPrimaryColor.opacity(0.15), lineWidth: 10)
                    .blur(radius: 10)
                    .offset(y: 8)

                Rectangle()
                    .fill(Color.clear)
                    .contentShape(Rectangle())
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                selectedIndex = nearestIndex(
                                    for: value.location.x,
                                    width: size.width
                                )
                            }
                    )

                VStack(spacing: 4) {
                    Text(formatCurrency(selectedData.amount))
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundStyle(Color.textTertiary)
                        .padding(.horizontal, AppChartStyle.tooltipHorizontalPadding)
                        .padding(.vertical, AppChartStyle.tooltipVerticalPadding)
                        .background(
                            Capsule()
                                .fill(AppChartStyle.tooltipBackground)
                        )

                    Circle()
                        .fill(Color.surface)
                        .frame(width: AppChartStyle.markerSize, height: AppChartStyle.markerSize)
                        .overlay(
                            Circle()
                                .stroke(Color.brandPrimaryColor, lineWidth: 3)
                        )
                }
                .position(
                    x: selectedPoint.x,
                    y: max(selectedPoint.y - 26, 22)
                )
                .animation(.easeOut(duration: 0.12), value: selectedIndex)
            }
        }
        .frame(height: 72)
    }

    @ViewBuilder
    public func toSkeleton(enable: Bool) -> some View {
        if enable {
            SpendingLineChartSkeleton()
        } else {
            self
        }
    }

    private func makePath(in size: CGSize) -> Path {
        var path = Path()

        guard points.count > 1 else { return path }

        let cgPoints = chartPoints(in: size)

        path.move(to: cgPoints[0])

        for index in 1..<cgPoints.count {
            let previous = cgPoints[index - 1]
            let current = cgPoints[index]
            let midX = (previous.x + current.x) / 2

            path.addCurve(
                to: current,
                control1: CGPoint(x: midX, y: previous.y),
                control2: CGPoint(x: midX, y: current.y)
            )
        }

        return path
    }

    private func chartPoints(in size: CGSize) -> [CGPoint] {
        let maxAmount = points.map(\.amount).max() ?? 1
        let minAmount = points.map(\.amount).min() ?? 0

        let range = maxAmount - minAmount
        let step = size.width / CGFloat(points.count - 1)

        let topPadding: CGFloat = 28
        let bottomPadding: CGFloat = 8
        let drawableHeight = size.height - topPadding - bottomPadding

        return points.enumerated().map { index, item in
            let normalized = range == 0 ? 0.5 : (item.amount - minAmount) / range

            return CGPoint(
                x: CGFloat(index) * step,
                y: topPadding + (1 - CGFloat(normalized)) * drawableHeight
            )
        }
    }

    private func point(at index: Int, in size: CGSize) -> CGPoint {
        chartPoints(in: size)[index]
    }

    private func nearestIndex(for xPosition: CGFloat, width: CGFloat) -> Int {
        guard points.count > 1 else { return 0 }

        let step = width / CGFloat(points.count - 1)
        let index = Int(round(xPosition / step))

        return min(max(index, 0), points.count - 1)
    }

    private func formatCurrency(_ value: Double) -> String {
        "$ \(String(format: "%.2f", value))"
    }
}

#Preview {
    SpendingLineChart()
        .padding()
        .appCardSurface()
        .padding()
        .appScreenBackground()
}
