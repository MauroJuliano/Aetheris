import SwiftUI

struct ProfileScreen: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
                VStack {
                    UserView()
                    
                    FormView(cells: FormCellModel.generalCellsMock)
                        .frame(maxWidth: .infinity)
                    
                    FormView(cells: FormCellModel.notifications)
                        .frame(maxWidth: .infinity)
                    
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
                                .foregroundStyle(Color.accentColorBrown)
                                .font(AppFont.roboto(.semibold, size: 16))
                                .shadow(color: .black.opacity(0.2), radius: 10, y: 5)
                        }
                        
                    }
                    
                    Spacer()
                    
                    Text("Version 0.00.1")
                        .foregroundStyle(.gray.opacity(0.25))
                        .font(AppFont.roboto(.regular, size: 16))
                        .padding(.top)
                    
                    Text("@2025 Powered by Blake")
                        .foregroundStyle(.gray.opacity(0.25))
                        .font(AppFont.roboto(.regular, size: 16))
                    
                    Text("Account terms - Privacy Policy")
                        .foregroundStyle(Color.accentColorBrown)
                        .font(AppFont.roboto(.semibold, size: 16))
                        .padding(.bottom, 100)
                }
        }
        .padding(.horizontal)
        .background(Color.backgroundColorA)
    }
}

#Preview {
    ProfileScreen()
}
