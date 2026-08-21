import AetherisDesignSystem
import Foundation
import SwiftUI

struct TransactionDetailsCard<Content: View>: View {
    let title: String
    let isLoading: Bool
    @ViewBuilder let content: Content

    init(
        title: String,
        isLoading: Bool = false,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.isLoading = isLoading
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if isLoading {
                SkeletonBlock(width: 180, height: 20, radius: 9)
                    .padding(.top, AppSpacing.medium)
                    .padding(.bottom, AppSpacing.small)
            } else {
                Text(title)
                    .font(AppTypography.sectionTitle)
                    .bold()
                    .foregroundStyle(Color.textPrimary)
                    .padding(.top, AppSpacing.medium)
                    .padding(.bottom, AppSpacing.small)
            }

            content
        }
        .padding(.horizontal, AppSpacing.medium)
        .frame(maxWidth: .infinity, alignment: .leading)
        .appCardSurface()
    }
}

struct TransactionDetailsDivider: View {
    var body: some View {
        Divider().padding(.leading, 52)
    }
}

func iconCircle(systemName: String, color: Color, size: CGFloat) -> some View {
    ZStack {
        Circle()
            .fill(color.opacity(0.1))
            .frame(width: size, height: size)

        Image(systemName: systemName)
            .font(.system(size: size * 0.42, weight: .medium))
            .foregroundStyle(color)
    }
}
