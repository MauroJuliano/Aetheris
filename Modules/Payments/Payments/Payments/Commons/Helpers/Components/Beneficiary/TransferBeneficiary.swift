import SwiftUI
import AetherisDesignSystem

public struct TransferBeneficiary: View {
    @Binding var shouldChange: Bool
    @Binding var model: Beneficiary
    
    @State private var rotateGradient: Bool
    
    public init(shouldChange: Binding<Bool>,
                model: Binding<Beneficiary>,
                rotateGradient: Bool = false) {
        self._shouldChange = shouldChange
        self._model = model
        self.rotateGradient = rotateGradient
    }
    
    public var body: some View {
        HStack(spacing: 16) {
            avatarView
            
            VStack(alignment: .leading, spacing: 4) {
                Text(model.name)
                    .font(.headline)
                    .foregroundStyle(Color.textPrimary)

                HStack(spacing: 6) {
                    Text(model.pixKey)
                        .font(.footnote)
                        .foregroundStyle(Color.textTertiary)
                        .lineLimit(2)
                        .truncationMode(.tail)
                        .layoutPriority(1)

                    Button {
                        UIPasteboard.general.string = model.pixKey
                    } label: {
                        Image(systemName: "doc.on.doc")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(Color.brandPrimaryColor)
                    }
                }
            }
            
            Button {
                shouldChange = true
            } label: {
                HStack(spacing: 6) {
                    Text("Change")
                        .font(.subheadline.weight(.semibold))
                    
                    Image(systemName: "pencil")
                        .font(.subheadline.weight(.semibold))
                }
                .foregroundStyle(Color.brandPrimaryColor)
                .padding(.horizontal, 16)
                .frame(height: 44)
                .background(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(Color.backgroundColorA)
                        .shadow(color: .black.opacity(0.06), radius: 10, y: 5)
                )
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 18)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color.backgroundColorA)
                .shadow(color: .black.opacity(0.08), radius: 24, x: 12, y: 12)
        )
    }
    
    private var avatarView: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.blue.opacity(0.35),
                    Color.purple.opacity(0.35)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(width: 72, height: 72)
            .clipShape(Circle())
            .blur(radius: 18)
            .rotationEffect(.degrees(rotateGradient ? 360 : 0))
            .animation(
                .linear(duration: 6).repeatForever(autoreverses: false),
                value: rotateGradient
            )
            
            Image(model.image)
                .resizable()
                .scaledToFill()
                .frame(width: 72, height: 72)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(.gray.opacity(0.25), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.12), radius: 10, y: 5)
        }
        .onAppear {
            rotateGradient = true
        }
    }
}

#Preview {
    TransferBeneficiary(shouldChange: .constant(true),
                        model: .constant(Beneficiary.beneficiaries.first!))
}
