import AetherisDesignSystem
import PaymentsInterface
import SwiftUI

struct MainTabContainer: View {
    @State private var selectedIndex = 0
    @State private var showSendMoney = false
    
    let paymentsFactory: PaymentsFactoryInterface
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                content
                
                TabBarView(selectedIndex: $selectedIndex,
                           onCenterTap: {
                    showSendMoney = true
                }
              )
            }
            .navigationDestination(isPresented: $showSendMoney) {
                paymentsFactory.make(
                    entryPoint: .sendMoney,
                    onFinished: {
                        showSendMoney = false
                    }
                )
            }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch selectedIndex {
        case 0:
            paymentsFactory.make(entryPoint: .home,
                                 onFinished: {})
        case 1:
            paymentsFactory.make(entryPoint: .card,
                                 onFinished: {})
        case 2:
            paymentsFactory.make(entryPoint: .profile, onFinished: {})
        default:
            EmptyView()
        }
    }
    
}
