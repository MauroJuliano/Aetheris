import SwiftUI

public struct NumericKeyboard: View {
    @Binding var text: String
    
    // Define the keys
    let keys = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        [".", "0", "⌫"]
    ]
    
    
    public init(text: Binding<String>) {
        self._text = text
    }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(.white)
            
            
            VStack(spacing: 10) {
                Spacer()
                
                ZStack(alignment: .leading) {
                    if text.isEmpty {
                        Text("$0.00") // placeholder
                            .foregroundColor(.gray)
                            .font(AppFont.roboto(.semibold, size: 38))
                    }
                    
                    Text(formatAmount(text))
                        .foregroundColor(.black)
                        .font(AppFont.roboto(.semibold, size: 38))
                }
                
                Text("Wallet balance: $96,764.00")
                    .foregroundStyle(.gray)
                    .font(AppFont.roboto(.regular, size: 18))
                
                Spacer()
                
                ForEach(keys, id: \.self) { row in
                    HStack(spacing: 10) {
                        ForEach(row, id: \.self) { key in
                            Button(action: {
                                handleKeyPress(key)
                            }) {
                                Text(key)
                                    .font(.title)
                                    .foregroundColor(Color.accentColorBrown)
                                    .shadow(color: .gray.opacity(0.2), radius: 16, y: 5)
                                    .frame(width: 100, height: 50)
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(Color.backgroundColorA)
                                            .shadow(color: .gray.opacity(0.2), radius: 16, y: 5)
                                    )
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .frame(width: 400, height: 400)
        .shadow(color: .gray.opacity(0.2), radius: 16, y: 5)
        
    }

    func formatAmount(_ input: String) -> String {
        // Remove non-digit characters
        let digits = input.filter { "0123456789".contains($0) }
        
        guard let number = Double(digits) else { return "$0.00" }
        
        let amount = number / 100 // to handle cents
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        return formatter.string(from: NSNumber(value: amount)) ?? "$0.00"
    }

    
    func handleKeyPress(_ key: String) {
        switch key {
        case "⌫":
            if !text.isEmpty {
                text.removeLast()
            }
        default:
            text.append(key)
        }
    }
}


#Preview {
    NumericKeyboard(text: .constant("1"))
}

