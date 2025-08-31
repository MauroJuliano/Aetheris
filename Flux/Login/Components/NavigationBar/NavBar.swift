import SwiftUI

struct NavBarModel {
    var firstText: String
    var secondText: String?
    var hasInitialSpace: Bool
}

struct NavBar: View {
    @State var hasNotifications: Bool = true
    @State var hasBackButton: Bool = false
    @State var model: NavBarModel
    var onBack: (() -> Void)?
    var onRightButtonAction: (() -> Void)?
    
    var body: some View {
        VStack {
            HStack() {
                if model.hasInitialSpace {
                    Spacer()
                }
                
                if hasBackButton {
                    Button {
                        onBack?()
                    } label: {
                        NotificationBell()
                    }
                }
                
                Text(model.firstText)
                    .font(AppFont.montserrat(.regular, size: 24))
                    .foregroundStyle(.gray)
                
                if let secondText = model.secondText {
                    Text(secondText)
                        .font(AppFont.montserrat(.bold, size: 24))
                        .foregroundStyle(.black)
                        .bold()
                }
                
                Spacer()
                
                Button {
                    onRightButtonAction?()
                } label: {
                    NotificationBell()
                }
            }
        }
        
    }
}

#Preview {
    NavBar(model: .init(firstText: "Welcome, ",
                        secondText: "Blake!",
                        hasInitialSpace: false))
}
