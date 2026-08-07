import AetherisDesignSystem
import SwiftUI

struct BeneficiaryInformationSection: View {
    let information: BeneficiaryInformationModel

    private var rows: [BeneficiaryInformationRowModel] {
        [
            information.email.map {
                BeneficiaryInformationRowModel(
                    title: Strings.BeneficiaryDetails.email,
                    value: $0,
                    icon: "envelope"
                )
            },
            information.phone.map {
                BeneficiaryInformationRowModel(
                    title: Strings.BeneficiaryDetails.phone,
                    value: $0,
                    icon: "phone"
                )
            },
            information.location.map {
                BeneficiaryInformationRowModel(
                    title: Strings.BeneficiaryDetails.location,
                    value: $0,
                    icon: "mappin.circle"
                )
            },
            information.accountInformation.map {
                BeneficiaryInformationRowModel(
                    title: Strings.BeneficiaryDetails.account,
                    value: $0,
                    icon: "building.columns"
                )
            }
        ]
        .compactMap { $0 }
    }

    var body: some View {
        if !rows.isEmpty {
            VStack(alignment: .leading, spacing: 0) {
                Text(Strings.BeneficiaryDetails.information)
                    .font(AppTypography.sectionTitle)
                    .bold()
                    .foregroundStyle(Color.textPrimary)
                    .padding(.horizontal, AppSpacing.medium)
                    .padding(.top, AppSpacing.medium)
                    .padding(.bottom, AppSpacing.small)

                ForEach(Array(rows.enumerated()), id: \.element.id) { index, row in
                    BeneficiaryInformationRow(model: row)

                    if index < rows.count - 1 {
                        Divider().padding(.leading, 56)
                    }
                }
            }
            .appCardSurface()
        }
    }
}

private struct BeneficiaryInformationRowModel: Identifiable {
    let id = UUID()
    let title: String
    let value: String
    let icon: String
}

private struct BeneficiaryInformationRow: View {
    let model: BeneficiaryInformationRowModel

    var body: some View {
        HStack(spacing: AppSpacing.medium) {
            Image(systemName: model.icon)
                .font(.system(size: 18, weight: .regular))
                .foregroundStyle(Color.brandPrimaryColor)
                .frame(width: 28)

            Text(model.title)
                .font(AppTypography.body)
                .foregroundStyle(Color.textPrimary)

            Spacer(minLength: AppSpacing.medium)

            Text(model.value)
                .font(AppTypography.body)
                .foregroundStyle(Color.textSecondaryColor)
                .multilineTextAlignment(.trailing)
                .lineLimit(2)
        }
        .padding(.horizontal, AppSpacing.medium)
        .padding(.vertical, AppSpacing.medium)
    }
}
