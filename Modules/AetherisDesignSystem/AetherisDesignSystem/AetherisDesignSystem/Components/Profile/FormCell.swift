import SwiftUI

public struct FormCell: View {
    let model: FormCellModel
    let hasDivider: Bool
    let onTap: (() -> Void)?
    
    public init(model: FormCellModel,
                hasDivider: Bool = false,
                onTap: (() -> Void)? = nil) {
        self.model = model
        self.hasDivider = hasDivider
        self.onTap = onTap
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
            if let title = model.sectionTitle {
                HStack {
                    Text(title)
                        .foregroundStyle(Color.textPrimary)
                        .font(AppTypography.sectionTitle)
                        .bold()
                        .multilineTextAlignment(.leading)
                        .padding(.top)
                    
                    Spacer()
                }
            }
            
            HStack {
                IconContainer(model: .init(icon: model.content.icon))
                
                Text(model.content.title)
                    .foregroundStyle(Color.textPrimary)
                    .font(AppTypography.cardBody)
                
                Spacer()
                
                if var toggle = model.content.toggle {
                    Toggle("", isOn: Binding(
                        get: { toggle.isOn },
                        set: { newValue in
                            toggle.isOn = newValue
                        }
                    ))
                    .tint(Color.brandPrimaryColor)
                    .labelsHidden()
                } else if model.content.showsDisclosureIndicator {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(Color.textTertiary)
                }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onTap?()
        }
        if hasDivider {
            Divider()
        }
    }

    @ViewBuilder
    public func toSkeleton(enable: Bool) -> some View {
        if enable {
            FormCellSkeleton(
                hasSectionTitle: model.sectionTitle != nil,
                hasDivider: hasDivider,
                showsToggle: model.content.toggle != nil
            )
        } else {
            self
        }
    }
}

#Preview {
    VStack(spacing: AppSpacing.medium) {
        FormCell(model: FormCellModel.generalCellsMock[0], hasDivider: true)
        FormCell(model: FormCellModel.notifications[0], hasDivider: false)
    }
    .padding()
    .appScreenBackground()
}
