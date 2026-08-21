import SwiftUI

public struct RecentContactItem: View {
    public let model: RecentContactItemModel
    public let onTap: () -> Void

    public init(
        model: RecentContactItemModel,
        onTap: @escaping () -> Void
    ) {
        self.model = model
        self.onTap = onTap
    }

    public var body: some View {
        Button(action: onTap) {
            VStack(spacing: AppSpacing.small) {
                avatar

                Text(model.firstName)
                    .font(AppTypography.cellCaption)
                    .bold()
                    .foregroundStyle(Color.textPrimary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .frame(width: 72)
            .padding(.vertical, AppSpacing.xSmall)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(model.name)
    }

    @ViewBuilder
    private var avatar: some View {
        if let imageName = model.imageName,
           !imageName.isEmpty {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 58, height: 58)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(Color.brandPrimaryColor.opacity(0.15), lineWidth: 2)
                }
        } else {
            ZStack {
                Circle()
                    .fill(Color.brandPrimaryColor.opacity(0.12))
                    .frame(width: 58, height: 58)

                Text(model.initials)
                    .font(AppTypography.body)
                    .bold()
                    .foregroundStyle(Color.brandPrimaryColor)
            }
        }
    }

    @ViewBuilder
    public func toSkeleton(enable: Bool) -> some View {
        if enable {
            RecentContactItemSkeleton()
        } else {
            self
        }
    }
}

#Preview {
    HStack(spacing: AppSpacing.medium) {
        RecentContactItem(
            model: .init(
                id: UUID(),
                name: "Sophie Keller",
                imageName: "sophie"
            ),
            onTap: {}
        )
    }
    .padding()
    .appScreenBackground()
}
