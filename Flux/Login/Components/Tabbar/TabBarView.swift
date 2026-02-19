import SwiftUI

struct TabBarView: View {
    @State private var selectedIndex = 0
    @State private var openSendMoney = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Group {
                    switch selectedIndex {
                    case 0:
                        HomeApp()
                    case 1:
                        CardHome()
                    case 2:
                        ProfileScreen()
                    default:
                        Text("Screen not found")
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                HStack(spacing: 40) {
                    TabBar(selectedIndex: $selectedIndex)
                        .shadow(color: .black.opacity(0.3),radius: 10, x: 0, y: 5)
                    
                    Button {
                        openSendMoney = true
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.black)
                                .frame(width: 50, height: 50)
                            
                            Image(systemName: "paperplane")
                                .foregroundColor(.white)
                        }
                    }
                    .shadow(color: .black.opacity(0.3),radius: 10, x: 0, y: 5)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 20)
            }
            .navigationDestination(isPresented: $openSendMoney) {
                SendMoney(shouldPresentTransfer: $openSendMoney)
            }
        }
    }
}

#Preview {
    TabBarView()
}

