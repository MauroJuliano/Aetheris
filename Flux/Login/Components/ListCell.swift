//
//  ListCell.swift
//  Flux
//
//  Created by maclau on 29/07/25.
//

import SwiftUI

struct ListCell: View {
    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .frame(width: 50, height: 50)
                    .clipShape(.buttonBorder)
                
                Image(systemName: "bag")
                    .resizable()
                    .foregroundStyle(.white)
                    .frame(width: 20, height: 25)
                    
            }
            
            VStack(alignment: .leading) {
                Text("Swarovski")
                
                Text("Payment")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .padding(.horizontal)
            
            Spacer()
            
            Text("-46.99")
                .foregroundStyle(.gray)
                .padding()
        }
        .padding(.horizontal)
    }
}

#Preview {
    ListCell()
}
