import SwiftUI

public struct PrimaryButton: View {
    private let title: String
    private let action: () -> Void

    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
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

                Text(title)
                    .foregroundStyle(Color.brandPrimaryColor)
                    .font(AppTypography.headline)
                    .appShadow(AppShadow.control)
            }
        }
    }
}

#Preview {
    PrimaryButton(title: "Continue") {}
        .padding()
        .appScreenBackground()
}
