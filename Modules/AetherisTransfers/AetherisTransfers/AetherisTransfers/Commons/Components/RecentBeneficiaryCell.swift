import AetherisDesignSystem
import SwiftUI
import AetherisTransfersInterface

struct RecentBeneficiaryCell: View {
    let model: Beneficiary
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            VStack(spacing: AppSpacing.small) {
                avatar

                Text(firstName)
                    .font(AppTypography.cellCaption)
                    .foregroundStyle(Color.textPrimary)
                    .bold()
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .frame(width: 72)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    private var avatar: some View {
        Image(model.image)
            .resizable()
            .scaledToFill()
            .frame(width: 58, height: 58)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(Color.brandPrimaryColor.opacity(0.15), lineWidth: 2)
            }
    }

    private var firstName: String {
        model.name
            .split(separator: " ")
            .first
            .map(String.init) ?? model.name
    }
}

#Preview {
    RecentBeneficiaryCell(
        model: BeneficiaryFixtures.defaults[0],
        onSelect: {}
    )
    .padding()
    .appScreenBackground()
}
