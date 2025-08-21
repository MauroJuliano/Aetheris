import SwiftUI

struct NavBar: View {
    @State var hasNotifications: Bool = true
    
    var body: some View {
        VStack {
            HStack() {
                Text("Welcome,")
                    .font(AppFont.montserrat(.regular, size: 24))
                    .foregroundStyle(.gray)
                
                Text("Blake!")
                    .font(AppFont.montserrat(.bold, size: 24))
                    .foregroundStyle(.black)
                    .bold()
                
                Spacer()
                
                Button {
                    
                } label: {
                    NotificationBell()
                }
            }
        }
        
    }
}

#Preview {
    NavBar()
}
