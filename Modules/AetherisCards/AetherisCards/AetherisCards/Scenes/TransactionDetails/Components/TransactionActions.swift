import AetherisDesignSystem
import SwiftUI

struct TransactionActions: View {
    let availableActions: [TransactionAction]
    let isDownloading: Bool
    let isLoading: Bool
    let onAction: (TransactionAction) -> Void

    var body: some View {
        HStack(spacing: 0) {
            if isLoading {
                ForEach(0..<4, id: \.self) { index in
                    VStack(spacing: AppSpacing.xSmall) {
                        SkeletonBlock(width: 24, height: 24, radius: 8)
                        SkeletonBlock(width: 60, height: 13, radius: 6)
                    }
                    .frame(maxWidth: .infinity)

                    if index < 3 {
                        Divider().frame(height: 54)
                    }
                }
            } else {
                ForEach(Array(availableActions.enumerated()), id: \.element.id) { index, action in
                    actionButton(action)

                    if index < availableActions.count - 1 {
                        Divider().frame(height: 54)
                    }
                }
            }
        }
        .padding(.vertical, AppSpacing.small)
        .appCardSurface()
    }

    private func actionButton(_ action: TransactionAction) -> some View {
        Button {
            onAction(action)
        } label: {
            VStack(spacing: AppSpacing.xSmall) {
                if action == .download && isDownloading {
                    ProgressView()
                        .tint(Color.brandPrimaryColor)
                        .frame(height: 22)
                } else {
                    Image(systemName: action.icon)
                        .font(.system(size: 20, weight: .regular))
                        .foregroundStyle(Color.brandPrimaryColor)
                        .frame(height: 22)
                }

                Text(action.title)
                    .font(AppTypography.cellCaption)
                    .foregroundStyle(Color.textSecondaryColor)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(action == .download && isDownloading)
    }
}

#Preview {
    TransactionActions(
        availableActions: [.share, .download, .addNote, .reportIssue],
        isDownloading: false,
        isLoading: false,
        onAction: { _ in }
    )
    .padding()
    .appScreenBackground()
}
