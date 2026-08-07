import AetherisDesignSystem
import SwiftUI

struct RecipientsContainer: View {
    let users: [Beneficiary]
    let onSelectRecipient: (Beneficiary) -> Void
    let onSeeAllTap: () -> Void
    let onNewRecipientTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium + AppSpacing.xxxSmall) {
            HStack {
                Text(Strings.Recipients.title)
                    .font(AppTypography.headline)
                    .foregroundStyle(Color.textPrimary)
                
                Spacer()
                
                Button(Strings.Recipients.seeAll) {
                    onSeeAllTap()
                }
                .font(AppTypography.subheadline.weight(.semibold))
                .foregroundStyle(Color.brandPrimaryColor)
            }
            
            HStack(spacing: AppSpacing.xLarge) {
                ForEach(users.prefix(4)) { user in
                    Button {
                        onSelectRecipient(user)
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
                    onNewRecipientTap()
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
                        
                        Text(Strings.Recipients.newRecipient)
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
    }
}

#Preview {
    RecipientsContainer(
        users: [
            Beneficiary(name: "Melissa", pixKey: "melissa@email.com", image: "melissa", hasDivider: false),
            Beneficiary(name: "Ed Sheeran", pixKey: "ed@email.com", image: "ed", hasDivider: false),
            Beneficiary(name: "Adele", pixKey: "adele@email.com", image: "Adele", hasDivider: false),
            Beneficiary(name: "Troy", pixKey: "troy@email.com", image: "Troy", hasDivider: false)
        ],
        onSelectRecipient: { _ in },
        onSeeAllTap: {},
        onNewRecipientTap: {}
    )
    .padding()
    .appScreenBackground()
}
