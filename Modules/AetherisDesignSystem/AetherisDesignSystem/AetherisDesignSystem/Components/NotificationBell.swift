import SwiftUI

public struct NotificationBell: View {
    public var body: some View {
        ZStack {
            Image(systemName: "bell")
                .font(.system(size: 24))
                .tint(.gray)
            
            Circle()
                .fill(Color.brandPrimaryColor)
                .frame(width: 10, height: 10)
                .offset(x: 5, y: -5)
        }
    }
}

#Preview {
    NotificationBell()
}
