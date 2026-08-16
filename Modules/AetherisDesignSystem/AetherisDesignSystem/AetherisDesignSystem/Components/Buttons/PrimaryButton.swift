import SwiftUI

public struct PrimaryButton: View {
    private let title: String
    private let action: () -> Void
    private let isLoading: Bool

    public init(
        title: String,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.action = action
        self.isLoading = isLoading
    }

    public var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                    .fill(Color.backgroundColorA)
                    .appShadow(AppShadow.card)
                    .overlay {
                        RoundedRectangle(cornerRadius: AppRadius.pill, style: .continuous)
                            .stroke(Color.border, lineWidth: 1)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)

                if isLoading {
                    ProgressView()
                        .tint(Color.brandPrimaryColor)
                } else {
                    Text(title)
                        .foregroundStyle(Color.brandPrimaryColor)
                        .font(AppTypography.headline)
                        .appShadow(AppShadow.control)
                }
            }
        }
        .disabled(isLoading)
    }
}

#Preview {
    PrimaryButton(title: "Continue") {}
        .padding()
        .appScreenBackground()
}
