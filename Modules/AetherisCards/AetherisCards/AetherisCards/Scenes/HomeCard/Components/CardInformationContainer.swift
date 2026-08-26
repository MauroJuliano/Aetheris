import AetherisDesignSystem
import SwiftUI

struct CardInformationContainer: View {
    let model: CardDetailsModel
    let onInvoiceTap: () -> Void
    let onDueDateTap: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            financialInformation
        }
        .appCardSurface()
    }

    @ViewBuilder
    func toSkeleton(enable: Bool) -> some View {
        if enable {
            CardInformationContainerSkeleton()
        } else {
            self
        }
    }

    private var financialInformation: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: AppSpacing.medium) {
                availableLimitView

                Divider()
                    .frame(height: 104)

                invoiceView
            }
            .padding(AppSpacing.medium)

            Divider()
                .padding(.horizontal, AppSpacing.medium)

            dueDateView
        }
    }

    private var availableLimitView: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
            Label {
                Text(Strings.CardInformation.availableLimit)
            } icon: {
                Image(systemName: "creditcard")
                    .foregroundStyle(Color.brandPrimaryColor)
            }
            .font(AppTypography.cellCaption)
            .foregroundStyle(Color.textSecondaryColor)

            Text(model.availableLimit.currencyFormatted)
                .font(AppTypography.onboardingBody)
                .bold()
                .foregroundStyle(Color.textPrimary)

            ProgressView(value: model.usedLimitProgress)
                .tint(Color.brandPrimaryColor)

            Text(Strings.CardInformation.totalLimit(model.totalLimit.currencyFormatted))
                .font(AppTypography.cellCaption)
                .foregroundStyle(Color.textTertiary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var invoiceView: some View {
        Button(action: onInvoiceTap) {
            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                HStack {
                    Label {
                        Text(Strings.CardInformation.currentInvoice)
                    } icon: {
                        Image(systemName: "doc.text")
                            .foregroundStyle(Color.brandPrimaryColor)
                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.caption.bold())
                        .foregroundStyle(Color.textTertiary)
                }
                .font(AppTypography.cellCaption)
                .foregroundStyle(Color.textSecondaryColor)

                Text(model.currentInvoice.currencyFormatted)
                    .font(AppTypography.onboardingBody)
                    .bold()
                    .foregroundStyle(Color.textPrimary)

                Text(model.invoiceStatus.title)
                    .font(AppTypography.cellCaption)
                    .foregroundStyle(Color.brandPrimaryColor)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    private var dueDateView: some View {
        Button(action: onDueDateTap) {
            HStack(spacing: AppSpacing.small) {
                CircleIcon(icon: "calendar", color: .brandPrimaryColor)

                VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
                    Text(Strings.CardInformation.dueDate)
                        .font(AppTypography.cellCaption)
                        .foregroundStyle(Color.textSecondaryColor)

                    Text(model.dueDate.dueDateFormatted)
                        .font(AppTypography.cellCaption)
                        .bold()
                        .foregroundStyle(Color.brandPrimaryColor)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption.bold())
                    .foregroundStyle(Color.textTertiary)
            }
            .padding(AppSpacing.medium)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

private struct CircleIcon: View {
    let icon: String
    let color: Color

    var body: some View {
        ZStack {
            Circle()
                .fill(color.opacity(0.08))
                .frame(
                    width: AppComponentMetrics.mediumCircleSize,
                    height: AppComponentMetrics.mediumCircleSize
                )

            Image(systemName: icon)
                .font(.system(size: AppCardMetrics.cardButtonIconSize, weight: .regular))
                .foregroundStyle(color)
        }
    }
}
