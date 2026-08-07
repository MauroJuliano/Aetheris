import AetherisDesignSystem
import SwiftUI

struct RecentContactButton: View {
    let contact: RequestContactModel
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: AppSpacing.xSmall) {
                ZStack(alignment: .bottomTrailing) {
                    avatar

                    Circle()
                        .fill(Color.success)
                        .frame(width: 12, height: 12)
                        .overlay {
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                        }
                }

                Text(contact.firstName)
                    .font(AppTypography.cellCaption)
                    .bold()
                    .foregroundStyle(Color.textPrimary)
                    .lineLimit(1)

                Text(contact.contactInformation)
                    .font(.system(size: 10))
                    .foregroundStyle(Color.textSecondaryColor)
                    .lineLimit(1)
            }
            .frame(width: 82)
            .padding(.vertical, AppSpacing.xSmall)
            .background(
                isSelected
                    ? Color.brandPrimaryColor.opacity(0.08)
                    : Color.clear
            )
            .clipShape(RoundedRectangle(cornerRadius: AppRadius.medium))
        }
        .buttonStyle(.plain)
        .accessibilityLabel(contact.name)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    @ViewBuilder
    private var avatar: some View {
        if let imageName = contact.imageName {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 58, height: 58)
                .clipShape(Circle())
        } else {
            ZStack {
                Circle()
                    .fill(Color.brandPrimaryColor.opacity(0.12))
                    .frame(width: 58, height: 58)

                Text(contact.initials)
                    .font(AppTypography.body)
                    .bold()
                    .foregroundStyle(Color.brandPrimaryColor)
            }
        }
    }
}

#Preview {
    HStack(spacing: AppSpacing.medium) {
        RecentContactButton(
            contact: .previewMelissa,
            isSelected: true,
            action: {}
        )

        RecentContactButton(
            contact: .previewCarlos,
            isSelected: false,
            action: {}
        )
    }
    .padding()
    .appScreenBackground()
}

extension RequestContactModel {
    static let previewMelissa = RequestContactModel(
        id: UUID(),
        name: "Melissa",
        contactInformation: "contact@melissamccarthy.com",
        imageName: "melissa"
    )

    static let previewCarlos = RequestContactModel(
        id: UUID(),
        name: "Carlos Barbosa",
        contactInformation: "carlos@email.com",
        imageName: nil
    )
}
