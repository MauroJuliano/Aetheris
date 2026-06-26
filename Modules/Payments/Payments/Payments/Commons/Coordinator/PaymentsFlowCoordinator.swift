import PaymentsInterface
import SwiftUI

struct PaymentsFlowCoordinator: View {
    let entryPoint: PaymentsEntryPoint
    let onFinished: () -> Void
    
    var body: some View {
        switch entryPoint {
        case .home:
            HomeApp()
            
        case .card:
            CardHome()
            
        case .sendMoney:
            SendMoney(
                onBackAction: {
                    onFinished()
                }
            )
        case .profile:
            ProfileScreen()
        }
    }
}
