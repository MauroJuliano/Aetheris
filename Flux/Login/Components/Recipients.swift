import SwiftUI

struct Recipients: View {
    
    var users = UserMock.users
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Recipients")
                       .font(.title3)
                       .fontWeight(.medium)
                
                Spacer()
            }
            
            HStack {
            ForEach(users) { user in
                    Image(user.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(.circle)
                        .frame(width: 50, height: 50)
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
    static var users: [User] = [.init(image: "melissa"), .init(image: "aria")]
}
