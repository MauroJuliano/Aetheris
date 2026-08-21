import SwiftUI

public struct RecipientsContainer: View {
    public let title: String
    public let seeAllTitle: String
    public let newRecipientTitle: String
    public let recipients: [RecipientItem]
    public let onSelectRecipient: (RecipientItem) -> Void
    public let onSeeAllTap: () -> Void
    public let onNewRecipientTap: () -> Void

    public init(
        title: String,
        seeAllTitle: String,
        newRecipientTitle: String,
        recipients: [RecipientItem],
        onSelectRecipient: @escaping (RecipientItem) -> Void,
        onSeeAllTap: @escaping () -> Void,
        onNewRecipientTap: @escaping () -> Void
    ) {
        self.title = title
        self.seeAllTitle = seeAllTitle
        self.newRecipientTitle = newRecipientTitle
        self.recipients = recipients
        self.onSelectRecipient = onSelectRecipient
        self.onSeeAllTap = onSeeAllTap
        self.onNewRecipientTap = onNewRecipientTap
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium + AppSpacing.xxxSmall) {
            HStack {
                Text(title)
                    .font(AppTypography.headline)
                    .foregroundStyle(Color.textPrimary)

                Spacer()

                Button(seeAllTitle, action: onSeeAllTap)
                    .font(AppTypography.subheadline.weight(.semibold))
                    .foregroundStyle(Color.brandPrimaryColor)
            }

            HStack(spacing: AppSpacing.xLarge) {
                ForEach(recipients.prefix(4)) { recipient in
                    Button {
                        onSelectRecipient(recipient)
                    } label: {
                        VStack(spacing: AppSpacing.xSmall) {
                            Image(recipient.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 58, height: 58)
                                .clipShape(Circle())

                            Text(recipient.name)
                                .font(AppTypography.caption)
                                .bold()
                                .foregroundStyle(Color.textPrimary)
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                                .frame(height: 32)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .accessibilityLabel(recipient.name)
                }

                Button(action: onNewRecipientTap) {
                    VStack(spacing: AppSpacing.xSmall) {
                        ZStack {
                            Circle()
                                .fill(Color.brandPrimaryColor.opacity(0.08))
                                .frame(width: 58, height: 58)

                            Image(systemName: "plus")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundStyle(Color.brandPrimaryColor)
                        }

                        Text(newRecipientTitle)
                            .font(AppTypography.caption)
                            .bold()
                            .foregroundStyle(Color.textPrimary)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .frame(height: 32)
                    }
                }
                .frame(maxWidth: .infinity)
                .accessibilityLabel(newRecipientTitle.replacingOccurrences(of: "\n", with: " "))
            }
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }

    @ViewBuilder
    public func toSkeleton(enable: Bool) -> some View {
        if enable {
            RecipientsContainerSkeleton()
        } else {
            self
        }
    }
}

#Preview {
    RecipientsContainer(
        title: "Recipients",
        seeAllTitle: "See all",
        newRecipientTitle: "New\nrecipient",
        recipients: [
            .init(id: UUID(), name: "Sophie Keller", imageName: "sophie"),
            .init(id: UUID(), name: "Amelia Thompson", imageName: "Amelia"),
            .init(id: UUID(), name: "Léa Tremblay", imageName: "lea"),
            .init(id: UUID(), name: "Maya Patel", imageName: "maya")
        ],
        onSelectRecipient: { _ in },
        onSeeAllTap: {},
        onNewRecipientTap: {}
    )
    .padding()
    .appScreenBackground()
}
