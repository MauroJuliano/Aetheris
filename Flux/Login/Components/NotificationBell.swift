import SwiftUI

struct NotificationBell: View {
    var body: some View {
        ZStack {
            Image(systemName: "bell")
                .font(.system(size: 24))
                .tint(.gray)
            
            Circle()
                .fill(.red)
                .frame(width: 10, height: 10)
                .offset(x: 5, y: -5)
        }
    }
}

#Preview {
    NotificationBell()
}
