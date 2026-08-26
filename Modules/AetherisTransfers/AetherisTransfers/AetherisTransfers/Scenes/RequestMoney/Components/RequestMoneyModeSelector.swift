import AetherisDesignSystem
import SwiftUI

struct RequestMoneyModeSelector: View {
    let selectedMode: RequestMoneyMode
    let onModeSelected: (RequestMoneyMode) -> Void

    var body: some View {
        HStack(spacing: AppSpacing.xSmall) {
            ForEach(RequestMoneyMode.allCases) { mode in
                modeButton(mode)
            }
        }
        .padding(AppSpacing.xxxSmall)
        .appCardSurface()
    }

    private func modeButton(_ mode: RequestMoneyMode) -> some View {
        let isSelected = selectedMode == mode

        return Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                onModeSelected(mode)
            }
        } label: {
            HStack(spacing: AppSpacing.xSmall) {
                Image(systemName: mode.icon)

                Text(mode.title)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .font(AppTypography.cellCaption)
            .bold()
            .foregroundStyle(isSelected ? Color.white : Color.brandPrimaryColor)
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .background {
                if isSelected {
                    LinearGradient(
                        colors: [
                            Color.brandPrimaryColor,
                            Color.brandSecondaryColor
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                } else {
                    Color.clear
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: AppRadius.medium))
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    @ViewBuilder
    func toSkeleton(enable: Bool) -> some View {
        if enable {
            RequestMoneyModeSelectorSkeleton()
        } else {
            self
        }
    }
}

#Preview {
    @Previewable @State var selectedMode: RequestMoneyMode = .contact

    RequestMoneyModeSelector(
        selectedMode: selectedMode,
        onModeSelected: { selectedMode = $0 }
    )
    .padding()
    .appScreenBackground()
}
