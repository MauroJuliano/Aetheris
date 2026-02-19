
import SwiftUI

struct NotificationsCentre: View {
    @Binding var isPresented: Bool
    @State var model: [Notification] = []
    
    var grouped: [String: [Notification]] {
        Dictionary(grouping: model) { $0.section }
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                NavBar(hasNotifications: false,
                       hasBackButton: true,
                       model: .init(firstText: "Notifications Centre",
                                    hasInitialSpace: false),
                       onBack: { isPresented = false })
                
                ForEach(grouped.keys.sorted(by: sortSections), id: \.self) { key in
                    VStack(alignment: .leading, spacing: 12) {
                        Text(key)
                            .foregroundStyle(.black)
                            .font(AppFont.roboto(.bold, size: 24))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        VStack {
                            ForEach(grouped[key] ?? []) { cell in
                                NotificationCell(model: cell)
                                    .padding(.horizontal)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.backgroundColorA)
                                .shadow(color: .gray.opacity(0.25), radius: 16, y: 5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(.gray.opacity(0.25), lineWidth: 1)
                                )
                        )
                    }
                }
                
            }
        }
        .padding(.horizontal)
        .background(Color.backgroundColorA)
        .task {
            await loadData()
        }
    }
    
    @MainActor
    func loadData() async {
        self.model = Notification.mock
    }
    
    func sortSections(lhs: String, rhs: String) -> Bool {
        let order = ["Today", "Yesterday", "Last Week", "Last Month", "Others"]
        return order.firstIndex(of: lhs)! < order.firstIndex(of: rhs)!
    }
}

#Preview {
    NotificationsCentre(isPresented: .constant(false), model: Notification.mock)
}
