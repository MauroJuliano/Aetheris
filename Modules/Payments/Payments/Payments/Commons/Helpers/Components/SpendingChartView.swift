import SwiftUI
import AetherisDesignSystem

struct SpendingThisMonthView: View {
    private let categories: [SpendingCategory] = [
        .init(title: "Shopping", amount: "$ 980.50", percentage: "40%", icon: "bag.fill", color: Color.brandPrimaryColor),
        .init(title: "Bills", amount: "$ 610.00", percentage: "25%", icon: "doc.text.fill", color: .cyan),
        .init(title: "Transport", amount: "$ 420.00", percentage: "17%", icon: "car.fill", color: Color.success),
        .init(title: "Food & Drinks", amount: "$ 417.50", percentage: "18%", icon: "fork.knife", color: .orange)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            header

            SpendingLineChart()
                .padding(.top, 2)

            categoriesRow
                .padding(.top, 4)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color.backgroundColorA)
                .shadow(color: .black.opacity(0.08), radius: 24, x: 0, y: 12)
        )
    }

    private var header: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Spending this month")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color.textPrimary)

                HStack(spacing: 12) {
                    Text("$ 2,428.00")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(Color.textPrimary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.85)
                        .layoutPriority(1)

                    HStack(spacing: 5) {
                        Image(systemName: "arrow.down")
                        Text("8.3%")
                    }
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(Color.success)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(Color.success.opacity(0.12))
                    )

                    Text("vs last month")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(Color.textTertiary)
                        .lineLimit(1)
                }
            }

            Spacer()

            Button {

            } label: {
                Text("View report")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Color.brandPrimaryColor)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 9)
                    .background(
                        Capsule()
                            .stroke(Color.brandPrimaryColor.opacity(0.25), lineWidth: 1)
                    )
            }
        }
    }

    private var categoriesRow: some View {
        HStack(spacing: 0) {
            ForEach(categories) { category in
                SpendingCategoryItem(category: category)

                if category.id != categories.last?.id {
                    Divider()
                        .frame(height: 38)
                }
            }
        }
    }
}

struct SpendingLineChart: View {
    private let points: [CGFloat] = [
        0.45, 0.52, 0.47, 0.44, 0.43, 0.62, 0.56, 0.50,
        0.51, 0.44, 0.58, 0.63, 0.47, 0.41, 0.48, 0.57,
        0.59, 0.64, 0.53, 0.56, 0.52, 0.61, 0.72, 0.45,
        0.43, 0.55, 0.60, 0.58, 0.49, 0.46, 0.42, 0.55
    ]

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let path = makePath(in: size)
            let highlightIndex = 22
            let highlightPoint = point(at: highlightIndex, in: size)

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

                VStack(spacing: 4) {
                    Text("$ 420.50")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundStyle(Color.textTertiary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 5)
                        .background(
                            Capsule()
                                .fill(Color.gray.opacity(0.12))
                        )

                    Circle()
                        .fill(Color.surface)
                        .frame(width: 10, height: 10)
                        .overlay(
                            Circle()
                                .stroke(Color.brandPrimaryColor, lineWidth: 3)
                        )
                }
                .position(x: highlightPoint.x, y: highlightPoint.y - 22)
            }
        }
        .frame(height: 72)
    }

    private func makePath(in size: CGSize) -> Path {
        var path = Path()

        guard points.count > 1 else { return path }

        let step = size.width / CGFloat(points.count - 1)

        let cgPoints = points.enumerated().map { index, value in
            CGPoint(
                x: CGFloat(index) * step,
                y: size.height - value * size.height
            )
        }

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

    private func point(at index: Int, in size: CGSize) -> CGPoint {
        let step = size.width / CGFloat(points.count - 1)
        let value = points[index]

        return CGPoint(
            x: CGFloat(index) * step,
            y: size.height - value * size.height
        )
    }
}

struct SpendingCategory: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let amount: String
    let percentage: String
    let icon: String
    let color: Color
}

struct SpendingCategoryItem: View {
    let category: SpendingCategory

    var body: some View {
        HStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(category.color.opacity(0.1))

                Image(systemName: category.icon)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(category.color)
            }
            .frame(width: 34, height: 34)

            VStack(alignment: .leading, spacing: 3) {
                Text(category.title)
                    .font(.system(size: 9, weight: .medium))
                    .foregroundStyle(Color.textTertiary)
                    .lineLimit(1)

                Text(category.amount)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(Color.textPrimary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)

                Text(category.percentage)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundStyle(Color.textTertiary)
                    .lineLimit(1)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    SpendingThisMonthView()
        .padding()
        .background(Color.backgroundColorA)
}
