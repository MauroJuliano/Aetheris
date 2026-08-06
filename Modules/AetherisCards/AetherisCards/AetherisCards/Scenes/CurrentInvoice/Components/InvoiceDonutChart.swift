import AetherisDesignSystem
import SwiftUI

struct InvoiceDonutChart: View {
    let installmentProgress: Double

    private var safeProgress: Double {
        min(max(installmentProgress, 0), 1)
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.brandPrimaryColor.opacity(0.2), lineWidth: 18)

            Circle()
                .trim(from: 0, to: safeProgress)
                .stroke(
                    AngularGradient(
                        colors: [
                            Color.brandPrimaryColor,
                            Color.brandSecondaryColor,
                            Color.brandTertiaryColor
                        ],
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: 18, lineCap: .butt)
                )
                .rotationEffect(.degrees(-90))
        }
        .accessibilityElement()
        .accessibilityLabel(Strings.CurrentInvoice.spendingDistribution)
        .accessibilityValue(Strings.CurrentInvoice.installmentAccessibilityValue(Int((safeProgress * 100).rounded())))
    }
}
