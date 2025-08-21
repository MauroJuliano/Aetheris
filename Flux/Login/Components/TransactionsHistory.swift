//
//  TransactionsHistory.swift
//  Flux
//
//  Created by maclau on 29/07/25.
//

import SwiftUI

struct TransactionsHistory: View {
    @State private var selectedOption = "Opção 1"
    
    let options = ["Opção 1", "Opção 2", "Opção 3"]
    
    var body: some View {
        VStack {
            MinimalDropdown()
                .padding()
            
            ListCell()
            ListCell()
            ListCell()
            ListCell()
            ListCell()
        }
    }
}

#Preview {
    TransactionsHistory()
}
