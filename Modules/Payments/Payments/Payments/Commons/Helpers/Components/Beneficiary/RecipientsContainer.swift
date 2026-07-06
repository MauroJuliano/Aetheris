import AetherisDesignSystem
import SwiftUI

struct RecipientsContainer: View {
    let users = Beneficiary.beneficiaries
    @State private var shouldPresentSendMoney: Bool = false
    @State private var userSelected: Beneficiary?
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium + AppSpacing.xxxSmall) {
            HStack {
                Text("Recipients")
                    .font(AppTypography.headline)
                    .foregroundStyle(Color.textPrimary)
                
                Spacer()
                
                Button("See all") {
                    // action
                }
                .font(AppTypography.subheadline.weight(.semibold))
                .foregroundStyle(Color.brandPrimaryColor)
            }
            
            HStack(spacing: AppSpacing.xLarge) {
                ForEach(users.prefix(4)) { user in
                    Button {
                        userSelected = user
                        shouldPresentSendMoney = true
                    } label: {
                        VStack(spacing: AppSpacing.xSmall) {
                            Image(user.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 58, height: 58)
                                .clipShape(Circle())
                            
                            Text(user.name)
                                .font(AppTypography.caption)
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
                    VStack(spacing: AppSpacing.xSmall) {
                        ZStack {
                            Circle()
                                .fill(Color.brandPrimaryColor.opacity(0.08))
                                .frame(width: 58, height: 58)
                            
                            Image(systemName: "plus")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundStyle(Color.brandPrimaryColor)
                        }
                        
                        Text("New\nrecipient")
                            .font(AppTypography.caption)
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
        .padding(AppSpacing.medium)
        .appCardSurface()
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
