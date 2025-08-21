//
//  HomeServices.swift
//  Flux
//
//  Created by maclau on 29/07/25.
//

import SwiftUI

struct HomeServices: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.gray)
                .frame(width: 350, height: 60)
                .clipShape(.buttonBorder)
                .padding()
                
            
            HStack {
                Text("Insurance")
                    .font(.headline)
                    .padding()
            
                Spacer()
                
                Image(systemName: "creditcard")
                    .resizable()
                    .foregroundStyle(.white)
                    .frame(width: 20, height: 20)
                    .padding()
            }
            .padding()
        }
        
        
    }
}

#Preview {
    HomeServices()
}
