import SwiftUI

public struct ContactCardRow: View {
    public let model: ContactCardRowModel
    public let onTap: () -> Void

    public init(
        model: ContactCardRowModel,
        onTap: @escaping () -> Void
    ) {
        self.model = model
        self.onTap = onTap
    }

    public var body: some View {
        Button(action: onTap) {
            HStack(spacing: AppSpacing.medium) {
                avatar

                information

                Spacer(minLength: AppSpacing.small)

                navigationButton
            }
            .padding(.horizontal, AppSpacing.medium)
            .padding(.vertical, AppSpacing.medium)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .appCardSurface()
        .accessibilityIdentifier("contactCardRow.cell")
    }

    @ViewBuilder
    private var avatar: some View {
        if let imageName = model.imageName,
           !imageName.isEmpty {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
        } else {
            ZStack {
                Circle()
                    .fill(Color.brandPrimaryColor.opacity(0.12))
                    .frame(width: 60, height: 60)

                Text(initials)
                    .font(AppTypography.body)
                    .bold()
                    .foregroundStyle(Color.brandPrimaryColor)
            }
        }
    }

    private var information: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
            Text(model.name)
                .font(AppTypography.callout)
                .bold()
                .foregroundStyle(Color.textPrimary)
                .lineLimit(1)

            Text(model.contactInformation)
                .font(AppTypography.cellCaption)
                .foregroundStyle(Color.textSecondaryColor)
                .lineLimit(1)
                .minimumScaleFactor(0.85)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var navigationButton: some View {
        Image(systemName: "chevron.forward")
            .font(.system(size: 18, weight: .semibold))
            .foregroundStyle(Color.brandPrimaryColor)
            .frame(width: 46, height: 46)
            .background {
                RoundedRectangle(cornerRadius: AppRadius.large)
                    .fill(Color.backgroundColorA)
            }
    }

    private var initials: String {
        model.name
            .split(separator: " ")
            .prefix(2)
            .compactMap(\.first)
            .map(String.init)
            .joined()
            .uppercased()
    }

    @ViewBuilder
    public func toSkeleton(enable: Bool) -> some View {
        if enable {
            ContactCardRowSkeleton()
        } else {
            self
        }
    }
}

#Preview {
    VStack(spacing: AppSpacing.medium) {
        ContactCardRow(
            model: .init(
                id: UUID(),
                name: "Sophie Keller",
                contactInformation: "sophie.keller@aetheris.app",
                imageName: "sophie"
            ),
            onTap: {}
        )
    }
    .padding()
    .appScreenBackground()
}
