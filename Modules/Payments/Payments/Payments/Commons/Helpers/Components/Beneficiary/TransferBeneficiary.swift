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
        HStack(spacing: AppSpacing.medium) {
            avatarView
            
            VStack(alignment: .leading, spacing: AppSpacing.xxSmall) {
                Text(model.name)
                    .font(AppTypography.headline)
                    .foregroundStyle(Color.textPrimary)

                HStack(spacing: AppSpacing.xxSmall + AppSpacing.xxxSmall) {
                    Text(model.pixKey)
                        .font(AppTypography.footnote)
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
                HStack(spacing: AppSpacing.xxSmall + AppSpacing.xxxSmall) {
                    Text("Change")
                        .font(AppTypography.subheadline.weight(.semibold))
                    
                    Image(systemName: "pencil")
                        .font(AppTypography.subheadline.weight(.semibold))
                }
                .foregroundStyle(Color.brandPrimaryColor)
                .padding(.horizontal, AppSpacing.medium)
                .frame(height: 44)
                .background(
                    RoundedRectangle(cornerRadius: AppRadius.card, style: .continuous)
                        .fill(Color.backgroundColorA)
                        .appShadow(AppShadow.chartGlow)
                )
            }
        }
        .padding(.horizontal, AppSpacing.medium)
        .padding(.vertical, AppSpacing.medium + AppSpacing.xxxSmall)
        .appCardSurface()
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
                        .stroke(Color.border, lineWidth: 1)
                )
                .appShadow(AppShadow.control)
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
