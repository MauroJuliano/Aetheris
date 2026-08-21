import SwiftUI

struct IconContainer: View {
    var model: IconContainerModel
    
    init(model: IconContainerModel) {
        self.model = model
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: AppRadius.small, style: .continuous)
                .fill(Color.brandPrimaryColor.opacity(0.08))
                .frame(width: AppComponentMetrics.smallCircleSize, height: AppComponentMetrics.smallCircleSize)

            Image(systemName: model.icon)
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(Color.brandPrimaryColor)
        }
    }
}

#Preview {
    HStack(spacing: AppSpacing.medium) {
        IconContainer(model: .init(icon: "person"))
        IconContainer(model: .init(icon: "envelope"))
        IconContainer(model: .init(icon: "creditcard"))
    }
    .padding()
    .appScreenBackground()
}
