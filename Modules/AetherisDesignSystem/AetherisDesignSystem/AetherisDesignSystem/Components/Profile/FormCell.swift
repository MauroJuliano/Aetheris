import SwiftUI

public struct FormCellModel: Identifiable {
    public let id: UUID = UUID()
    var sectionTitle: String?
    var content: FormContent
    
    public init(sectionTitle: String? = nil,
                content: FormContent) {
        self.sectionTitle = sectionTitle
        self.content = content
    }
    
    public struct FormContent {
        var title: String
        var icon: String
        var hasDivider: Bool
        var toggle: FormToggle?
        
        struct FormToggle {
            var isOn: Bool
        }
    }
    
    public static let generalCellsMock: [FormCellModel] = [
        FormCellModel(sectionTitle: "General",
                      content: .init(title: "Melissa Mccarthy",
                                     icon: "person",
                                     hasDivider: true)),
        FormCellModel(sectionTitle: nil,
                      content: .init(title: "contact@melissamccarthy.com",
                                     icon: "envelope",
                                     hasDivider: true)),
        FormCellModel(sectionTitle: nil,
                      content: .init(title: "(33) 9908-3213",
                                     icon: "iphone.gen2",
                                     hasDivider: true)),
        FormCellModel(sectionTitle: nil,
                      content: .init(title: "Feedback",
                                     icon: "bubble",
                                     hasDivider: true))
    ]
    
    public static let notifications: [FormCellModel] = [
        FormCellModel(sectionTitle: "Notifications",
                      content: .init(title: "Push notifications",
                                     icon: "message.badge",
                                     hasDivider: true,
                                     toggle: .init(isOn: true))),
        FormCellModel(sectionTitle: nil,
                      content: .init(title: "sms notifications",
                                     icon: "text.bubble",
                                     hasDivider: false,
                                     toggle: .init(isOn: true)))
    ]
}

public struct FormCell: View {
    @State var model: FormCellModel
    let hasDivider: Bool
    
    public init(model: FormCellModel,
                hasDivider: Bool = false) {
        self.model = model
        self.hasDivider = hasDivider
    }
    
    public var body: some View {
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
            }
        }
        
        if hasDivider {
            Divider()
        }
    }
}

#Preview {
    var model = FormCellModel(sectionTitle: "General",
                              content: .init(title: "contact@melissamccarthy.com",
                                             icon: "envelope",
                                             hasDivider: true))
    FormCell(model: model)
}
