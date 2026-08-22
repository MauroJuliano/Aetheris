import SwiftUI

public struct FormCellModel: Identifiable {
    public let id: UUID = UUID()
    public var sectionTitle: String?
    public var content: FormContent
    
    public init(sectionTitle: String? = nil,
                content: FormContent) {
        self.sectionTitle = sectionTitle
        self.content = content
    }
    
    public struct FormContent {
        public enum Kind: Hashable {
            case general
            case name
            case email
            case phone
            case feedback
            case pushNotifications
            case smsNotifications
        }

        public var kind: Kind?
        public var title: String
        public var icon: String
        public var hasDivider: Bool
        public var toggle: FormToggle?
        public var showsDisclosureIndicator: Bool
        
        public struct FormToggle {
            public var isOn: Bool

            public init(isOn: Bool) {
                self.isOn = isOn
            }
        }

        public init(
            kind: Kind? = nil,
            title: String,
            icon: String,
            hasDivider: Bool,
            toggle: FormToggle? = nil,
            showsDisclosureIndicator: Bool
        ) {
            self.kind = kind
            self.title = title
            self.icon = icon
            self.hasDivider = hasDivider
            self.toggle = toggle
            self.showsDisclosureIndicator = showsDisclosureIndicator
        }
    }
    
    public static let generalCellsMock: [FormCellModel] = [
        FormCellModel(sectionTitle: Strings.Profile.generalSection,
                      content: .init(kind: .name,
                                     title: Strings.Profile.userName,
                                     icon: "person",
                                     hasDivider: true,
                                     showsDisclosureIndicator: true)),
        FormCellModel(sectionTitle: nil,
                      content: .init(kind: .email,
                                     title: Strings.Profile.email,
                                     icon: "envelope",
                                     hasDivider: true,
                                     showsDisclosureIndicator: true)),
        FormCellModel(sectionTitle: nil,
                      content: .init(kind: .phone,
                                     title: Strings.Profile.phone,
                                     icon: "iphone.gen2",
                                     hasDivider: true,
                                     showsDisclosureIndicator: true)),
        FormCellModel(sectionTitle: nil,
                      content: .init(kind: .feedback,
                                     title: Strings.Profile.feedback,
                                     icon: "bubble",
                                     hasDivider: true,
                                     showsDisclosureIndicator: true))
    ]
    
    public static let notifications = notificationCells(pushIsOn: true, smsIsOn: true)

    public static func notificationCells(
        pushIsOn: Bool,
        smsIsOn: Bool
    ) -> [FormCellModel] {
        [FormCellModel(sectionTitle: Strings.Profile.notificationsSection,
                      content: .init(kind: .pushNotifications,
                                     title: Strings.Profile.pushNotifications,
                                     icon: "message.badge",
                                     hasDivider: true,
                                     toggle: .init(isOn: pushIsOn),
                                     showsDisclosureIndicator: false)),
        FormCellModel(sectionTitle: nil,
                      content: .init(kind: .smsNotifications,
                                     title: Strings.Profile.smsNotifications,
                                     icon: "text.bubble",
                                     hasDivider: false,
                                     toggle: .init(isOn: smsIsOn),
                                     showsDisclosureIndicator: false))
        ]
    }

    public static func profileCells(
        name: String,
        email: String,
        phone: String
    ) -> [FormCellModel] {
        [
            FormCellModel(
                sectionTitle: Strings.Profile.generalSection,
                content: .init(
                    kind: .name,
                    title: name,
                    icon: "person",
                    hasDivider: true,
                    showsDisclosureIndicator: true
                )
            ),
            FormCellModel(
                sectionTitle: nil,
                content: .init(
                    kind: .email,
                    title: email,
                    icon: "envelope",
                    hasDivider: true,
                    showsDisclosureIndicator: true
                )
            ),
            FormCellModel(
                sectionTitle: nil,
                content: .init(
                    kind: .phone,
                    title: phone,
                    icon: "iphone.gen2",
                    hasDivider: true,
                    showsDisclosureIndicator: true
                )
            ),
            FormCellModel(
                sectionTitle: nil,
                content: .init(
                    kind: .feedback,
                    title: Strings.Profile.feedback,
                    icon: "bubble",
                    hasDivider: true,
                    showsDisclosureIndicator: true
                )
            )
        ]
    }
}

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
