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
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.backgroundColorA)
                                .shadow(color: .gray.opacity(0.25), radius: 16, y: 5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(.gray.opacity(0.25), style: .init(lineWidth: 1))
                                )
                                .frame(width: 300, height: 50)
                            
                            Text("Logout")
                                .foregroundStyle(Color.brandPrimaryColor)
                                .font(AppFont.roboto(.semibold, size: 16))
                                .shadow(color: .black.opacity(0.2), radius: 10, y: 5)
                        }
                    }
                    .padding(.vertical)
                    
                    Spacer()
                    
                    Text("Version 0.00.1")
                        .foregroundStyle(.gray.opacity(0.25))
                        .font(.footnote)
                        .padding(.top)
                    
                    Text("@2025 Powered by Blake")
                        .foregroundStyle(.gray.opacity(0.25))
                        .font(.footnote)
                    
                    Text("Account terms - Privacy Policy")
                        .foregroundStyle(Color.brandPrimaryColor)
                        .font(AppFont.roboto(.semibold, size: 16))
                        .padding(.bottom, 100)
                }
            }
            .opacity(isLoading ? 0 : 1)

            ProfileScreenSkeleton()
                .opacity(isLoading ? 1 : 0)
        }
        .padding(.horizontal)
        .background(Color.backgroundColorA)
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
