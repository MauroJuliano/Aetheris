import AetherisDesignSystem
import SwiftUI

struct ProfileScreen: View {
    @State private var isLoading = true

    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    UserView()
                    
                    FormView(cells: FormCellModel.generalCellsMock)
                        
                    FormView(cells: FormCellModel.notifications)
                     
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: AppRadius.large)
                                .fill(Color.backgroundColorA)
                                .appShadow(AppShadow.card)
                                .overlay(
                                    RoundedRectangle(cornerRadius: AppRadius.pill)
                                        .stroke(Color.border, style: .init(lineWidth: 1))
                                )
                                .frame(width: 300, height: 50)
                            
                            Text("Logout")
                                .foregroundStyle(Color.brandPrimaryColor)
                                .font(AppTypography.button)
                                .appShadow(AppShadow.control)
                        }
                    }
                    .padding(.vertical, AppSpacing.medium)
                    
                    Spacer()
                    
                    Text("Version 0.00.1")
                        .foregroundStyle(Color.textTertiary.opacity(0.5))
                        .font(AppTypography.footnote)
                        .padding(.top, AppSpacing.medium)
                    
                    Text("@2025 Powered by Blake")
                        .foregroundStyle(Color.textTertiary.opacity(0.5))
                        .font(AppTypography.footnote)
                    
                    Text("Account terms - Privacy Policy")
                        .foregroundStyle(Color.brandPrimaryColor)
                        .font(AppTypography.button)
                        .padding(.bottom, AppSpacing.bottomBarClearance)
                }
            }
            .opacity(isLoading ? 0 : 1)

            ProfileScreenSkeleton()
                .opacity(isLoading ? 1 : 0)
        }
        .padding(.horizontal, AppSpacing.screenHorizontal)
        .appScreenBackground()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.easeOut(duration: 0.5)) {
                    isLoading = false
                }
            }
        }
    }
}

#Preview {
    ProfileScreen()
}
