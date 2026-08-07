import AetherisDesignSystem
import SwiftUI

struct CardLockPreview: View {
    let model: CardLockModel

    var body: some View {
        ZStack {
            background

            VStack(alignment: .leading, spacing: 0) {
                header

                Spacer()

                Text(model.maskedNumber)
                    .font(.system(size: 22, weight: .medium, design: .rounded))
                    .foregroundStyle(model.style.cardsForegroundColor)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)

                Spacer()

                footer
            }
            .padding(AppSpacing.large)
        }
        .aspectRatio(1.58, contentMode: .fit)
        .opacity(model.isBlocked ? 0.88 : 1)
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("cardLock.card")
    }

    private var background: some View {
        RoundedRectangle(cornerRadius: AppRadius.card)
            .fill(
                LinearGradient(
                    colors: model.style.cardsGradientColors,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .overlay {
                model.style.cardsAccentOverlay
                    .clipShape(RoundedRectangle(cornerRadius: AppRadius.card))
            }
            .overlay {
                decorativeShapes
                    .clipShape(RoundedRectangle(cornerRadius: AppRadius.card))
            }
            .overlay {
                if model.isBlocked {
                    RoundedRectangle(cornerRadius: AppRadius.card)
                        .fill(Color.black.opacity(0.12))
                }
            }
            .shadow(
                color: model.style.cardsShadowColor,
                radius: 14,
                y: 7
            )
    }

    private var header: some View {
        HStack {
            statusBadge

            Spacer()

            Image(systemName: model.isBlocked ? "lock.fill" : "wave.3.right")
                .font(.system(size: 22, weight: .medium))
                .foregroundStyle(model.style.cardsForegroundColor)
        }
    }

    private var statusBadge: some View {
        HStack(spacing: AppSpacing.xxxSmall) {
            Image(systemName: model.isBlocked ? "lock.fill" : "lock.open.fill")
                .font(.caption)

            Text(model.isBlocked ? Strings.CardLock.blocked : Strings.CardLock.unblocked)
                .font(AppTypography.cellCaption)
                .bold()
        }
        .foregroundStyle(Color.white)
        .padding(.horizontal, AppSpacing.small)
        .padding(.vertical, AppSpacing.xxxSmall)
        .background(statusColor)
        .clipShape(Capsule())
    }

    private var statusColor: Color {
        model.isBlocked ? Color.error.opacity(0.8) : Color.success.opacity(0.8)
    }

    private var footer: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: AppSpacing.medium) {
                VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
                    Text(Strings.CardLock.validUntil)
                        .font(AppTypography.cellCaption)
                        .foregroundStyle(model.style.cardsSecondaryForegroundColor)

                    Text(model.expirationDate)
                        .font(AppTypography.body)
                        .bold()
                        .foregroundStyle(model.style.cardsForegroundColor)
                }

                Text(model.holderName.uppercased())
                    .font(AppTypography.body)
                    .bold()
                    .foregroundStyle(model.style.cardsForegroundColor)
                    .lineLimit(1)
            }

            Spacer()

            Text(model.brand.rawValue)
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(model.style.cardsForegroundColor)
        }
    }

    private var decorativeShapes: some View {
        GeometryReader { proxy in
            Circle()
                .fill(Color.white.opacity(0.08))
                .frame(
                    width: proxy.size.width * 0.72,
                    height: proxy.size.width * 0.72
                )
                .offset(
                    x: proxy.size.width * 0.58,
                    y: -proxy.size.height * 0.28
                )

            Circle()
                .fill(Color.black.opacity(0.06))
                .frame(
                    width: proxy.size.width * 0.82,
                    height: proxy.size.width * 0.82
                )
                .offset(
                    x: -proxy.size.width * 0.24,
                    y: proxy.size.height * 0.42
                )
        }
    }
}
