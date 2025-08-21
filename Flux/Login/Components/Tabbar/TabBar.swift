import SwiftUI

struct TabBar: View {
    @Binding var selectedIndex: Int
    let tabWidth: CGFloat = 80
    
    var body: some View {
        HStack(spacing: 40) {
            ZStack {
                // Background
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.black)
                    .frame(width: 250, height: 50)
                    .shadow(radius: 10)
                
                // Moving White Capsule
                HStack(spacing: 0) {
                    ForEach(0..<3) { index in
                        Color.clear
                            .frame(width: tabWidth, height: 40)
                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .frame(width: tabWidth, height: 40)
                        .offset(x: CGFloat(selectedIndex - 1) * tabWidth)
                        .animation(.easeInOut(duration: 0.3), value: selectedIndex)
                )
                
                // Tab Items
                HStack(spacing: 0) {
                    tabItem(icon: "house", label: "Home", index: 0)
                    tabItem(icon: "chart.bar", label: "Cards", index: 1)
                    tabItem(icon: "person", label: "Profile", index: 2)
                }
            }
        }
        
    }
    
    @ViewBuilder
    func tabItem(icon: String, label: String, index: Int) -> some View {
        Button(action: {
            selectedIndex = index
        }) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                    .foregroundColor(selectedIndex == index ? .black : .white)
                
                if selectedIndex == index {
                    Text(label)
                        .font(.caption)
                        .foregroundColor(selectedIndex == index ? .black : .white)
                }
            }
            .frame(width: tabWidth, height: 50)
        }
    }
    
}

#Preview {
    TabBarPreviewWrapper()
}

struct TabBarPreviewWrapper: View {
    @State private var selectedIndex = 0

    var body: some View {
        TabBar(selectedIndex: $selectedIndex)
    }
}
