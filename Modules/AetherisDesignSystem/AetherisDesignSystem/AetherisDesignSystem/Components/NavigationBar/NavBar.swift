import SwiftUI

public struct NavBarModel {
    var firstText: String
    var secondText: String?
    var hasInitialSpace: Bool
    
    public init(firstText: String,
                secondText: String? = nil,
                hasInitialSpace: Bool) {
        self.firstText = firstText
        self.secondText = secondText
        self.hasInitialSpace = hasInitialSpace
    }
}

public struct NavBar: View {
    @State private var hasNotifications: Bool
    @State private var hasBackButton: Bool
    @State private var shouldPresentNotifications: Bool
    @State private var model: NavBarModel
    private var onBack: (() -> Void)?
    private var onRightButtonAction: (() -> Void)?
    
    public init(hasNotifications: Bool = true,
                hasBackButton: Bool = false,
                shouldPresentNotifications: Bool = false,
                model: NavBarModel,
                onBack: (() -> Void)? = nil,
                onRightButtonAction: (() -> Void)? = nil) {
        self.hasNotifications = hasNotifications
        self.hasBackButton = hasBackButton
        self.shouldPresentNotifications = shouldPresentNotifications
        self.model = model
        self.onBack = onBack
        self.onRightButtonAction = onRightButtonAction
    }
    
    public var body: some View {
        VStack {
            HStack() {
                if model.hasInitialSpace {
                    Spacer()
                }
                
                if hasBackButton {
                    Button {
                        onBack?()
                    } label: {
                        
                        ZStack {
                            Circle()
                                .fill(Color.backgroundColorA)
                                .frame(width: 40, height: 40)
                                .shadow(color: .gray.opacity(0.2), radius: 16, y: 5)
                            
                            Image(systemName: "chevron.left")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.black)
                                .shadow(color: .gray.opacity(0.2), radius: 16, y: 5)
                                .frame(width: 10, height: 20)
                        }
                        
                    }
                }
                
                VStack {
                    Text("\(model.firstText)")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundStyle(Color.brandPrimaryColor)
                    
                    if let secondText = model.secondText {
                        Text(secondText)
                            .font(.system(size: 34, weight: .bold))
                            .foregroundStyle(Color.textPrimary)
                    }
                }
                
                Spacer()
                
                if hasNotifications {
                    Button {
                        onRightButtonAction?()
                    } label: {
                        NotificationBell()
                    }
                }
            }
        }
    }
}

#Preview {
    NavBar(model: .init(firstText: "Good morning, ",
                        secondText: "Blake!",
                        hasInitialSpace: false))
}
