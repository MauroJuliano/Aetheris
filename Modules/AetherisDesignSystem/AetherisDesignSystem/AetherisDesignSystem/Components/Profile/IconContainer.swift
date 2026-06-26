import SwiftUI

struct IconContainerModel {
    let icon: String
}

struct IconContainer: View {
    var model: IconContainerModel
    
    init(model: IconContainerModel) {
        self.model = model
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(
                    Color.purple.opacity(0.08)
                )
                .frame(width: 28, height: 28)

            Image(systemName: model.icon)
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(Color.brandPrimaryColor)
        }
    }
}

#Preview {
    IconContainer(model: .init(icon: "person"))
}
