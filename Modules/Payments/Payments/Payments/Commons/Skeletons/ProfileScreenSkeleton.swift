import AetherisDesignSystem
import SwiftUI

struct ProfileScreenSkeleton: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: AppSpacing.medium + AppSpacing.xxxSmall) {
                user
                formSection(rows: 4, titleWidth: 90)
                formSection(rows: 2, titleWidth: 150, hasToggle: true)
                logoutButton
                footer
            }
            .padding(.top, AppSpacing.xSmall + AppSpacing.xxxSmall)
            .padding(.bottom, AppSpacing.bottomBarClearance)
        }
        .appScreenBackground()
    }

    private var user: some View {
        HStack(spacing: AppSpacing.medium + AppSpacing.xxxSmall) {
            SkeletonView(.circle)
                .frame(width: 120, height: 120)

            VStack(alignment: .leading, spacing: AppSpacing.small) {
                skeleton(width: 155, height: 22, radius: 11)
                skeleton(width: 130, height: 14, radius: 7)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, AppSpacing.xxSmall + AppSpacing.xxxSmall)
    }

    private func formSection(rows: Int, titleWidth: CGFloat, hasToggle: Bool = false) -> some View {
        VStack(spacing: 0) {
            HStack {
                skeleton(width: titleWidth, height: 28, radius: 14)
                Spacer()
            }
            .padding(.horizontal, 5)
            .padding(.top, 10)
            .padding(.bottom, 14)

            ForEach(0..<rows, id: \.self) { index in
                HStack(spacing: AppSpacing.medium - AppSpacing.xxxSmall) {
                    skeleton(width: 40, height: 40, radius: 14)

                    skeleton(width: rowTextWidth(for: index, hasToggle: hasToggle), height: 16, radius: 8)

                    Spacer()

                    if hasToggle {
                        skeleton(width: 48, height: 28, radius: 14)
                    }
                }
                .padding(.horizontal, 5)
                .padding(.vertical, AppSpacing.xSmall + AppSpacing.xxxSmall)

                if index < rows - 1 {
                    Divider()
                        .padding(.leading, 59)
                }
            }
        }
        .padding(AppSpacing.medium)
        .appCardSurface()
    }

    private var logoutButton: some View {
        skeleton(width: 300, height: 50, radius: 20)
            .padding(.vertical)
    }

    private var footer: some View {
        VStack(spacing: 10) {
            skeleton(width: 88, height: 12, radius: 6)
                .opacity(0.55)
            skeleton(width: 140, height: 12, radius: 6)
                .opacity(0.55)
            skeleton(width: 210, height: 18, radius: 9)
        }
        .padding(.top, 8)
    }

    private func rowTextWidth(for index: Int, hasToggle: Bool) -> CGFloat {
        if hasToggle {
            return index == 0 ? 145 : 130
        }

        switch index {
        case 0:
            return 150
        case 1:
            return 210
        case 2:
            return 130
        default:
            return 92
        }
    }

    private func skeleton(width: CGFloat? = nil, height: CGFloat, radius: CGFloat) -> some View {
        SkeletonView(.rect)
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
    }
}

