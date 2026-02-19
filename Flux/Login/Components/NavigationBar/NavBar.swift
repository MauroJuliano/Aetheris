import SwiftUI

struct NavBarModel {
    var firstText: String
    var secondText: String?
    var hasInitialSpace: Bool
}

struct NavBar: View {
    @State var hasNotifications: Bool = true
    @State var hasBackButton: Bool = false
    @State var shouldPresentNotifications: Bool = false
    @State var model: NavBarModel
    var onBack: (() -> Void)?
    var onRightButtonAction: (() -> Void)?
    
    var body: some View {
        NavigationStack {
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
                    
                    if hasNotifications {
                        Button {
                            shouldPresentNotifications = true
                        } label: {
                            NotificationBell()
                        }
                    }
                }
            }
        }
        .navigationDestination(isPresented: $shouldPresentNotifications) {
            NotificationsCentre(isPresented: $shouldPresentNotifications)
                .navigationBarHidden(true)
        }
    }
}

#Preview {
    NavBar(model: .init(firstText: "Welcome, ",
                        secondText: "Blake!",
                        hasInitialSpace: false))
}
