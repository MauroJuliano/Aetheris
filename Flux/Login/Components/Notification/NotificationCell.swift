import SwiftUI

import SwiftUI

struct Notification: Identifiable {
    let id: UUID = UUID()
    let title: String
    let image: String
    let date: Date
    let hasDivider: Bool
    
    // For previews & testing
    static let mock: [Notification] = [
        Notification(title: "Funds successfully transferred to Melissa",
                     image: "melissa",
                     date: Date(), // now → today
                     hasDivider: true),
        
        Notification(title: "Payment received from Ed",
                     image: "ed",
                     date: Date(), // now → today
                     hasDivider: true),
        
        Notification(title: "Subscription renewed for Man's best Friend",
                     image: "sabrina",
                     date: Date(), // now → today
                     hasDivider: true),
        
        Notification(title: "Payment received from Troy",
                     image: "Troy",
                     date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, // yesterday
                     hasDivider: true),
        
        Notification(title: "Refund processed successfully",
                     image: "NetflixLogo",
                     date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, // last week
                     hasDivider: true),
        
        Notification(title: "Your subscription has expired",
                     image: "netflix",
                     date: Calendar.current.date(byAdding: .day, value: -20, to: Date())!, // last month
                     hasDivider: true),
        
        Notification(title: "System maintenance completed",
                     image: "system",
                     date: Calendar.current.date(byAdding: .month, value: -2, to: Date())!, // older
                     hasDivider: true)
    ]
}

extension Notification {
    var section: String {
        let calendar = Calendar.current
        let now = Date()
        
        if calendar.isDateInToday(date) {
            return "Today"
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday"
        } else if let weekAgo = calendar.date(byAdding: .day, value: -7, to: now),
                  date >= weekAgo {
            return "Last Week"
        } else if let monthAgo = calendar.date(byAdding: .month, value: -1, to: now),
                  date >= monthAgo {
            return "Last Month"
        } else {
            return "Others"
        }
    }
}

struct NotificationCell: View {
    @State var model: Notification
    
    var body: some View {
        HStack(spacing: 12) {
            Image(model.image)
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .foregroundStyle(.black)

            Text(model.title)
                .foregroundStyle(.black)
                .font(AppFont.roboto(.regular, size: 16))

            Spacer()

//            VStack(alignment: .trailing, spacing: 4) {
//                Text(model.hour)
//                    .font(.subheadline)
//                    .foregroundStyle(.gray)
//
//                Spacer()
//            }
        }
        .frame(maxHeight: 50) // optional: keeps row height consistent
        .padding(.vertical, 8)
        
        if model.hasDivider {
            Divider()
        }
    }
}

#Preview {
    NotificationCell(model: .mock.first!)
}
