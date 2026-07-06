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
                                .appShadow(AppShadow.card)
                            
                            Image(systemName: "chevron.left")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(Color.textPrimary)
                                .frame(width: 10, height: 20)
                        }
                        
                    }
                }
                
                VStack {
                    Text("\(model.firstText)")
                        .font(AppTypography.navTitle)
                        .foregroundStyle(Color.brandPrimaryColor)
                    
                    if let secondText = model.secondText {
                        Text(secondText)
                            .font(AppTypography.heroTitle)
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
        .padding(.horizontal, AppSpacing.screenHorizontal)
     
    }
}

#Preview {
    NavBar(model: .init(firstText: "Good morning, ",
                        secondText: "Blake!",
                        hasInitialSpace: false))
}
