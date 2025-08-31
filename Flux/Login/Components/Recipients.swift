import SwiftUI

struct Recipients: View {
    
    var users = UserMock.users
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Recipients")
                    .foregroundStyle(.black)
                    .font(AppFont.roboto(.medium, size: 20))
                
                Spacer()
            }
            
            HStack {
            ForEach(users) { user in
                    Image(user.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(.circle)
                        .frame(width: 50, height: 50)
                        .shadow(color: .black.opacity(0.3),radius: 10, x: 0, y: 5)
                }
            }
        }
        .padding()
    }
}

#Preview {
    Recipients()
}


struct User: Identifiable {
    let id: UUID = UUID()
    var image: String
}


struct UserMock {
    static var users: [User] = [.init(image: "melissa"), .init(image: "aria"), .init(image: "caroline"), .init(image: "jadewest")]
}
