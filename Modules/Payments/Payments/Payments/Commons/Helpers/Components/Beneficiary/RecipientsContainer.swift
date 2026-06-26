import AetherisDesignSystem
import SwiftUI

struct RecipientsContainer: View {
    let users = Beneficiary.beneficiaries
    @State private var shouldPresentSendMoney: Bool = false
    @State private var userSelected: Beneficiary?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Text("Recipients")
                    .font(.headline)
                    .foregroundStyle(Color.textPrimary)
                
                Spacer()
                
                Button("See all") {
                    // action
                }
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(Color.brandPrimaryColor)
            }
            
            HStack(spacing: 24) {
                ForEach(users.prefix(4)) { user in
                    Button {
                        userSelected = user
                        shouldPresentSendMoney = true
                    } label: {
                        VStack(spacing: 8) {
                            Image(user.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 58, height: 58)
                                .clipShape(Circle())
                            
                            Text(user.name)
                                .font(.caption)
                                .bold()
                                .foregroundStyle(Color.textPrimary)
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                                .frame(height: 32)
                            
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                
                Button {
                    
                } label: {
                    VStack(spacing: 8) {
                        ZStack {
                            Circle()
                                .fill(Color.gray.opacity(0.08))
                                .frame(width: 58, height: 58)
                            
                            Image(systemName: "plus")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundStyle(Color.brandPrimaryColor)
                        }
                        
                        Text("New\nrecipient")
                            .font(.caption)
                            .bold()
                            .foregroundStyle(Color.textPrimary)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .frame(height: 32)
                            
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color.backgroundColorA)
                .shadow(color: .black.opacity(0.08), radius: 24, x: 12, y: 12)
        )
        .navigationDestination(isPresented: $shouldPresentSendMoney) {
            if let model = userSelected {
                SendMoney(model: model)
            }
            
        }
    }
}

#Preview {
    RecipientsContainer()
}
