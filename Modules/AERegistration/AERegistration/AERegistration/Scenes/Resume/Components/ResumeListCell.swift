import SwiftUI
import AetherisDesignSystem

struct ResumeListCell: View {
    let model: ResumeListModel
    let hasDivider: Bool
    var onChange: ((ResumeListModel) -> Void)? = nil

    init(
        model: ResumeListModel,
        hasDivider: Bool = false,
        onChange: ((ResumeListModel) -> Void)? = nil
    ) {
        self.model = model
        self.hasDivider = hasDivider
        self.onChange = onChange
    }

    var body: some View {
        Button {
            onChange?(model)
        } label: {
            HStack(spacing: AppSpacing.medium) {
                iconView

                contentView

                Spacer(minLength: AppSpacing.medium)

                Image(systemName: "chevron.forward")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color.textTertiary)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .appListCellRow(
            hasDivider: hasDivider,
            dividerLeading: 62,
            horizontalPadding: AppSpacing.medium,
            verticalPadding: AppSpacing.medium
        )
    }
}

private extension ResumeListCell {

    var iconView: some View {
        RoundedRectangle(
            cornerRadius: 14,
            style: .continuous
        )
        .fill(Color.brandPrimaryColor.opacity(0.10))
        .frame(width: 48, height: 48)
        .overlay {
            Image(systemName: model.image)
                .font(.system(size: 19, weight: .medium))
                .foregroundStyle(Color.brandPrimaryColor)
        }
    }

    var contentView: some View {
        VStack(
            alignment: .leading,
            spacing: 4
        ) {
            Text(model.description)
                .font(AppTypography.cellSubtitle)
                .foregroundStyle(Color.textSecondaryColor)

            Text(model.value)
                .font(AppTypography.onboardingBody)
                .foregroundStyle(Color.textPrimary)
                .lineLimit(1)
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
    }
}

#Preview {
    VStack(spacing: 0) {
        ResumeListCell(
            model: ResumeListModel(
                image: "person.fill",
                description: "Full name",
                value: "Melissa Mccarthy"
            ),
            hasDivider: true
        )

        ResumeListCell(
            model: ResumeListModel(
                image: "calendar",
                description: "Date of birth",
                value: "October 18, 1996"
            ),
            hasDivider: true
        )

        ResumeListCell(
            model: ResumeListModel(
                image: "heart.fill",
                description: "Mother's name",
                value: "Jane Smith"
            ),
            hasDivider: true
        )

        ResumeListCell(
            model: ResumeListModel(
                image: "lock.fill",
                description: "Social Insurance Number",
                value: "••• ••• 222"
            )
        )
    }
    .appCardSurface(
        radius: AppRadius.large,
        stroke: Color.border,
        shadow: AppShadow.card
    )
    .padding()
    .appScreenBackground()
}
