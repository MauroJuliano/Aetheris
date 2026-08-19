import SwiftUI

public struct VirtualCardQuickActions: View {
    public let isGeneratingNewNumber: Bool
    public let copyNumberTitle: String
    public let generateNewNumberTitle: String
    public let settingsTitle: String
    public let onCopyNumberTap: () -> Void
    public let onGenerateNewNumberTap: () -> Void
    public let onSettingsTap: () -> Void

    public init(
        isGeneratingNewNumber: Bool,
        copyNumberTitle: String,
        generateNewNumberTitle: String,
        settingsTitle: String,
        onCopyNumberTap: @escaping () -> Void,
        onGenerateNewNumberTap: @escaping () -> Void,
        onSettingsTap: @escaping () -> Void
    ) {
        self.isGeneratingNewNumber = isGeneratingNewNumber
        self.copyNumberTitle = copyNumberTitle
        self.generateNewNumberTitle = generateNewNumberTitle
        self.settingsTitle = settingsTitle
        self.onCopyNumberTap = onCopyNumberTap
        self.onGenerateNewNumberTap = onGenerateNewNumberTap
        self.onSettingsTap = onSettingsTap
    }

    public var body: some View {
        HStack(spacing: AppSpacing.small) {
            actionButton(title: copyNumberTitle, icon: "doc.on.doc", action: onCopyNumberTap)

            actionButton(
                title: generateNewNumberTitle,
                icon: "arrow.clockwise",
                isLoading: isGeneratingNewNumber,
                action: onGenerateNewNumberTap
            )

            actionButton(title: settingsTitle, icon: "gearshape", action: onSettingsTap)
        }
        .padding(.horizontal, AppSpacing.small)
        .padding(.vertical, AppSpacing.medium)
        .appCardSurface()
    }

    @ViewBuilder
    public func toSkeleton(enable: Bool) -> some View {
        if enable {
            VirtualCardQuickActionsSkeleton(actionsCount: 3)
        } else {
            self
        }
    }

    private func actionButton(
        title: String,
        icon: String,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            VStack(spacing: AppSpacing.xSmall) {
                ZStack {
                    Circle()
                        .fill(Color.brandPrimaryColor.opacity(0.08))
                        .frame(
                            width: AppComponentMetrics.mediumCircleSize,
                            height: AppComponentMetrics.mediumCircleSize
                        )

                    if isLoading {
                        ProgressView()
                            .tint(Color.brandPrimaryColor)
                    } else {
                        Image(systemName: icon)
                            .font(.system(size: AppCardMetrics.cardButtonIconSize, weight: .regular))
                            .foregroundStyle(Color.brandPrimaryColor)
                    }
                }

                Text(title)
                    .font(AppTypography.cellCaption)
                    .bold()
                    .foregroundStyle(Color.textPrimary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .frame(height: AppComponentMetrics.glassButtonLabelHeight)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(isLoading)
    }
}

#Preview {
    VStack(spacing: AppSpacing.medium) {
        VirtualCardQuickActions(
            isGeneratingNewNumber: false,
            copyNumberTitle: "Copy number",
            generateNewNumberTitle: "Generate new number",
            settingsTitle: "Settings",
            onCopyNumberTap: {},
            onGenerateNewNumberTap: {},
            onSettingsTap: {}
        )
        VirtualCardQuickActions(
            isGeneratingNewNumber: true,
            copyNumberTitle: "Copy number",
            generateNewNumberTitle: "Generate new number",
            settingsTitle: "Settings",
            onCopyNumberTap: {},
            onGenerateNewNumberTap: {},
            onSettingsTap: {}
        )
    }
    .padding()
    .appScreenBackground()
}
