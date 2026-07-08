import SwiftUI

public struct MinimalDropdown: View {
    @State private var selectedOption: String
    @State private var isExpanded: Bool

    let title: String
    let options: [String]

    public init(
        title: String = "Transactions History",
        selectedOption: String = "Today",
        isExpanded: Bool = false,
        options: [String] = ["Today", "This Week", "This Month", "All Time"]
    ) {
        self.title = title
        self._selectedOption = State(initialValue: selectedOption)
        self._isExpanded = State(initialValue: isExpanded)
        self.options = options
    }
    
    public var body: some View {
        HStack {
            Text(title)
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
