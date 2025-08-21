import SwiftUI

struct BalanceView: View {
    var body: some View {
        HStack {
            Text("$ 13,553.00")
                .font(.title)
                .bold()
                .foregroundStyle(.black)
                .padding(.leading)
            
            Text("Balance")
                .font(.headline)
                .foregroundStyle(.gray)
            
            Spacer()
        }
        .padding(.top)
        
    }
}

#Preview {
    BalanceView()
}
