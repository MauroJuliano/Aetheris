import AetherisDesignSystem
import SwiftUI

struct VirtualCardView: View {
    let model: VirtualCardModel
    let isContentVisible: Bool
    let onVisibilityTap: () -> Void

    var body: some View {
        ZStack {
            cardBackground

            VStack(alignment: .leading, spacing: 0) {
                header

                Spacer()

                cardNumber

                Spacer()

                footer
            }
            .padding(AppSpacing.large)
        }
        .aspectRatio(1.58, contentMode: .fit)
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("virtualCard.card")
    }

    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: AppRadius.card, style: .continuous)
            .fill(
                LinearGradient(
                    colors: [
                        Color.brandPrimaryColor,
                        Color.brandSecondaryColor,
                        Color.brandTertiaryColor
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .overlay {
                decorativeShapes
                    .clipShape(RoundedRectangle(cornerRadius: AppRadius.card, style: .continuous))
            }
            .shadow(color: Color.brandPrimaryColor.opacity(0.25), radius: 16, y: 8)
    }

    private var decorativeShapes: some View {
        GeometryReader { proxy in
            Circle()
                .fill(Color.white.opacity(0.08))
                .frame(width: proxy.size.width * 0.7, height: proxy.size.width * 0.7)
                .offset(x: proxy.size.width * 0.55, y: -proxy.size.height * 0.2)

            Circle()
                .fill(Color.black.opacity(0.06))
                .frame(width: proxy.size.width * 0.8, height: proxy.size.width * 0.8)
                .offset(x: -proxy.size.width * 0.25, y: proxy.size.height * 0.45)
        }
    }

    private var header: some View {
        HStack {
            Text("VIRTUAL")
                .font(AppTypography.cellCaption)
                .bold()
                .foregroundStyle(Color.white)
                .padding(.horizontal, AppSpacing.small)
                .padding(.vertical, AppSpacing.xxxSmall)
                .overlay {
                    RoundedRectangle(cornerRadius: AppRadius.small, style: .continuous)
                        .stroke(Color.white.opacity(0.6))
                }

            Spacer()

            Button(action: onVisibilityTap) {
                Image(systemName: isContentVisible ? "eye.slash" : "eye")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundStyle(Color.white)
                    .frame(width: 44, height: 44)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel(isContentVisible ? "Ocultar dados do cartão" : "Mostrar dados do cartão")
        }
    }

    private var cardNumber: some View {
        Text(isContentVisible ? model.formattedNumber : model.maskedNumber)
            .font(.system(size: 23, weight: .medium, design: .rounded))
            .foregroundStyle(Color.white)
            .lineLimit(1)
            .minimumScaleFactor(0.75)
            .accessibilityLabel("Número do cartão")
            .accessibilityValue(isContentVisible ? model.formattedNumber : "Número oculto")
    }

    private var footer: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: AppSpacing.medium) {
                HStack(spacing: AppSpacing.xLarge) {
                    cardField(title: "Válido até", value: isContentVisible ? model.expirationDate : "••/••")
                    cardField(title: "CVC", value: isContentVisible ? model.securityCode : "•••")
                }

                Text(model.holderName.uppercased())
                    .font(AppTypography.body)
                    .bold()
                    .foregroundStyle(Color.white)
                    .lineLimit(1)
            }

            Spacer()

            Text(model.brand.rawValue)
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(Color.white)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
        }
    }

    private func cardField(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
            Text(title)
                .font(AppTypography.cellCaption)
                .foregroundStyle(Color.white.opacity(0.8))

            Text(value)
                .font(AppTypography.body)
                .bold()
                .foregroundStyle(Color.white)
        }
    }
}
