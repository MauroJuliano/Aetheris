import SwiftUI

public struct MinimalDropdown: View {
    @State private var selectedOption = "Today"
    @State private var isExpanded = false

    let options = ["Today", "This Week", "This Month", "All Time"]

    public init(selectedOption: String = "Today",
                isExpanded: Bool = false) {
        self.selectedOption = selectedOption
        self.isExpanded = isExpanded
    }
    
    public var body: some View {
        HStack {
            Text("Transactions History")
                .font(AppTypography.onboardingBody)
                .fontWeight(.medium)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 8) {
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                    HStack(spacing: 4) {
                        Text(selectedOption)
                            .foregroundColor(.primary)
                        Image(systemName: "chevron.down")
                            .font(.system(size: 10))
                            .rotationEffect(.degrees(isExpanded ? 180 : 0))
                            .animation(.easeInOut(duration: 0.2), value: isExpanded)
                    }
                }
                .buttonStyle(.plain)
                
                if isExpanded {
                    VStack(alignment: .leading, spacing: 4) {
                        ForEach(options, id: \.self) { option in
                            Button(action: {
                                selectedOption = option
                                withAnimation {
                                    isExpanded = false
                                }
                            }) {
                                Text(option)
                                    .foregroundColor(.primary)
                                    .padding(.vertical, 4)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.top, 4)
                }
            }
            .padding()
        }
    }
}


#Preview {
    MinimalDropdown()
}
