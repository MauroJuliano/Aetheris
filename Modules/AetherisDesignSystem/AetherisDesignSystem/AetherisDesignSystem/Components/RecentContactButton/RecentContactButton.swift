import SwiftUI

public struct RecentContactButtonModel: Identifiable, Hashable {
    public let id: UUID
    public let name: String
    public let contactInformation: String
    public let imageName: String?

    public init(
        id: UUID,
        name: String,
        contactInformation: String,
        imageName: String?
    ) {
        self.id = id
        self.name = name
        self.contactInformation = contactInformation
        self.imageName = imageName
    }

    public var firstName: String {
        name.split(separator: " ").first.map(String.init) ?? name
    }

    public var initials: String {
        name
            .split(separator: " ")
            .prefix(2)
            .compactMap(\.first)
            .map(String.init)
            .joined()
            .uppercased()
    }
}

public struct RecentContactButton: View {
    public let contact: RecentContactButtonModel
    public let isSelected: Bool
    public let onTap: () -> Void

    public init(
        contact: RecentContactButtonModel,
        isSelected: Bool,
        onTap: @escaping () -> Void
    ) {
        self.contact = contact
        self.isSelected = isSelected
        self.onTap = onTap
    }

    public var body: some View {
        Button(action: onTap) {
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
            .background(isSelected ? Color.brandPrimaryColor.opacity(0.08) : Color.clear)
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

    @ViewBuilder
    public func toSkeleton(enable: Bool) -> some View {
        if enable {
            RecentContactButtonSkeleton()
        } else {
            self
        }
    }
}

#Preview {
    HStack(spacing: AppSpacing.medium) {
        RecentContactButton(
            contact: .init(
                id: UUID(),
                name: "Sophie Keller",
                contactInformation: "sophie.keller@aetheris.app",
                imageName: "sophie"
            ),
            isSelected: true,
            onTap: {}
        )

        RecentContactButton(
            contact: .init(
                id: UUID(),
                name: "Carlos Barbosa",
                contactInformation: "carlos@email.com",
                imageName: nil
            ),
            isSelected: false,
            onTap: {}
        )
    }
    .padding()
    .appScreenBackground()
}
