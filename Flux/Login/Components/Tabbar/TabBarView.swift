import SwiftUI

struct TabBarView: View {
    @State private var selectedIndex = 0
    @State private var openSendMoney = false
    
    var body: some View {
        NavigationStack {
            ZStack() {
                Color(.systemGray6)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    
                    Group {
                        switch selectedIndex {
                        case 0:
                            HomeApp()
                        case 1:
                            ContentView()
                        case 2:
                            NotificationBell()
                        default:
                            Text("Tela não encontrada")
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    Spacer(minLength: 0)
                    
                    HStack(spacing: 40) {
                        TabBar(selectedIndex: $selectedIndex)
                        
                        Button {
                            openSendMoney = true
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color.black)
                                    .frame(width: 50, height: 50)
                                
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $openSendMoney) {
                ContentView()
            }
        }
    }
}


#Preview {
    TabBarView()
}
