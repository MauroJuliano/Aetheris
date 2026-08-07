import SwiftUI
import AetherisTransfersInterface
import AetherisDesignSystem

public struct TransferBeneficiary: View {
    let onChange: () -> Void
    @Binding var model: Beneficiary?
    
    @State private var rotateGradient: Bool
    
    public init(onChange: @escaping () -> Void,
                model: Binding<Beneficiary?>,
                rotateGradient: Bool = false) {
        self.onChange = onChange
        self._model = model
        self.rotateGradient = rotateGradient
    }
    
    public var body: some View {
        Button(action: onChange) {
            HStack(spacing: AppSpacing.medium) {
                avatarView

                VStack(alignment: .leading, spacing: AppSpacing.xxSmall) {
                    Text(title)
                        .font(AppTypography.headline)
                        .foregroundStyle(Color.textPrimary)

                    if let model {
                        HStack(spacing: AppSpacing.xxSmall + AppSpacing.xxxSmall) {
                            Text(model.pixKey)
                                .font(AppTypography.footnote)
                                .foregroundStyle(Color.textTertiary)
                                .lineLimit(2)
                                .truncationMode(.tail)
                                .layoutPriority(1)

                            Image(systemName: "doc.on.doc")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundStyle(Color.brandPrimaryColor)
                                .onTapGesture {
                                    UIPasteboard.general.string = model.pixKey
                                }
                        }
                    } else {
                        Text(Strings.TransferBeneficiary.selectDescription)
                            .font(AppTypography.footnote)
                            .foregroundStyle(Color.textTertiary)
                            .lineLimit(2)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: AppSpacing.xxSmall + AppSpacing.xxxSmall) {
                    Text(actionTitle)
                        .font(AppTypography.subheadline.weight(.semibold))

                    Image(systemName: actionIcon)
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
                .fixedSize()
            }
            .padding(.horizontal, AppSpacing.medium)
            .padding(.vertical, AppSpacing.medium + AppSpacing.xxxSmall)
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .appCardSurface()
    }

    private var title: String {
        model?.name ?? Strings.TransferBeneficiary.selectTitle
    }

    private var actionTitle: String {
        model == nil
            ? Strings.TransferBeneficiary.select
            : Strings.TransferBeneficiary.change
    }

    private var actionIcon: String {
        model == nil ? "chevron.right" : "pencil"
    }

    private var avatarView: some View {
        ZStack {
            if let model {
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
            } else {
                ZStack {
                    Circle()
                        .fill(Color.brandPrimaryColor.opacity(0.08))
                        .frame(width: 72, height: 72)

                    Image(systemName: "person")
                        .font(.system(size: 28, weight: .medium))
                        .foregroundStyle(Color.brandPrimaryColor)
                }
            }
        }
        .onAppear {
            rotateGradient = true
        }
    }
}
