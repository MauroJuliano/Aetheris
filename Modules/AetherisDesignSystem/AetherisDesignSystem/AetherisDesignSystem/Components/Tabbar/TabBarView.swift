import SwiftUI

public struct TabBarView: View {
    @Binding var selectedIndex: Int
    var onCenterTap: () -> Void
    
    public init(
        selectedIndex: Binding<Int>,
        onCenterTap: @escaping () -> Void
    ) {
        self._selectedIndex = selectedIndex
        self.onCenterTap = onCenterTap
    }
    
    public var body: some View {
            ZStack(alignment: .bottom) {
                HStack(spacing: 40) {
                    TabBar(selectedIndex: $selectedIndex)
                        .shadow(color: .black.opacity(0.3),radius: 10, x: 0, y: 5)
                    
                    Button {
                        onCenterTap()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(.white)
                                .frame(width: 50, height: 50)
                            
                            Image(systemName: "paperplane")
                                .foregroundColor(Color.brandPrimaryColor)
                        }
                    }
                    .shadow(color: .black.opacity(0.3),radius: 10, x: 0, y: 5)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 20)
            }
    }
}

#Preview {
    TabBarView(selectedIndex: .constant(0), onCenterTap: {
        print("preview")
    })
}

