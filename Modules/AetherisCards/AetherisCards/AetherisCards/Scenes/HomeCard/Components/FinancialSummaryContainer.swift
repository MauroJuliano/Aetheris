import AetherisDesignSystem
import SwiftUI

struct FinancialSummaryContainer: View {
    let summaries: [FinancialSummaryModel]
    let title: String?
    let actionTitle: String?
    let onTap: () -> Void
    let onActionTap: () -> Void

    init(summaries: [FinancialSummaryModel],
         title: String? = nil,
         actionTitle: String? = nil,
         onTap: @escaping () -> Void = {},
         onActionTap: @escaping () -> Void = {}) {
        self.summaries = summaries
        self.title = title
        self.actionTitle = actionTitle
        self.onTap = onTap
        self.onActionTap = onActionTap
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            header

            VStack {
                ForEach(summaries) { transfer in
                    FinancialSummary(model: transfer,
                                     hasDivider: transfer.id != summaries.last?.id)
                }
            }
            .padding(.horizontal, AppSpacing.medium)
            .padding(.top, title == nil ? AppSpacing.medium : AppSpacing.small)
            .padding(.bottom, AppSpacing.medium)
        }
        .appCardSurface()
        .contentShape(RoundedRectangle(cornerRadius: AppRadius.card, style: .continuous))
        .onTapGesture {
            onTap()
        }
    }

    @ViewBuilder
    func toSkeleton(enable: Bool) -> some View {
        if enable {
            FinancialSummaryContainerSkeleton()
        } else {
            self
        }
    }

    @ViewBuilder
    private var header: some View {
        if let title {
            HStack {
                Text(title)
                    .font(AppTypography.onboardingBody)
                    .bold()
                    .foregroundStyle(Color.textPrimary)

                Spacer()

                if let actionTitle {
                    Button(action: onActionTap) {
                        HStack(spacing: AppSpacing.xxxSmall) {
                            Text(actionTitle)
                            Image(systemName: "chevron.right")
                        }
                        .font(AppTypography.cellCaption)
                        .bold()
                        .foregroundStyle(Color.brandPrimaryColor)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, AppSpacing.medium)
            .padding(.top, AppSpacing.medium)
        }
    }
}
