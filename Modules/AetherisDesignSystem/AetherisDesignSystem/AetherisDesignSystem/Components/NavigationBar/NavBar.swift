import SwiftUI

public struct NavBarModel {
    var firstText: String?
    var secondText: String?
    var hasInitialSpace: Bool
    
    public init(firstText: String? = nil,
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
                                .frame(width: AppComponentMetrics.navigationIconButtonSize, height: AppComponentMetrics.navigationIconButtonSize)
                                .appShadow(AppShadow.card)
                            
                            Image(systemName: "chevron.left")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(Color.textPrimary)
                                .frame(width: AppComponentMetrics.navigationChevronSize.width, height: AppComponentMetrics.navigationChevronSize.height)
                        }
                        
                    }
                }
                
                if let firstText = model.firstText {
                    VStack {
                        Text(firstText)
                            .font(AppTypography.navTitle)
                            .foregroundStyle(Color.brandPrimaryColor)

                        if let secondText = model.secondText {
                            Text(secondText)
                                .font(AppTypography.heroTitle)
                                .foregroundStyle(Color.textPrimary)
                        }
                    }
                }
                
                Spacer()
                
                if hasNotifications {
                    Button {
                        onRightButtonAction?()
                    } label: {
                        NotificationBell(showBadge: shouldPresentNotifications)
                    }
                }
            }
        }
        .padding(.horizontal, AppSpacing.screenHorizontal)
     
    }
}

#Preview {
    VStack(spacing: AppSpacing.xLarge) {
        NavBar(
            shouldPresentNotifications: true,
            model: .init(
                firstText: "Welcome",
                secondText: "Blake",
                hasInitialSpace: false
            )
        )

        NavBar(
            hasNotifications: false,
            hasBackButton: true,
            model: .init(
                firstText: "Details",
                hasInitialSpace: false
            )
        )
    }
    .padding(.vertical)
    .appScreenBackground()
}
