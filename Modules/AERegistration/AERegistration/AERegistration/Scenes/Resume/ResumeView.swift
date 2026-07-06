import AetherisDesignSystem
import SwiftUI

struct ResumeModel: Identifiable {
    let id: UUID
    let name: String
    let mothersName: String
    let birthDate: String
    let sin: String
    let userName: String
    let address: String
    
    init(id: UUID = UUID(),
         name: String,
         mothersName: String,
         birthDate: String,
         sin: String,
         userName: String,
         address: String) {
        self.id = id
        self.name = name
        self.mothersName = mothersName
        self.birthDate = birthDate
        self.sin = sin
        self.userName = userName
        self.address = address
    }
    
    static var mock: ResumeModel = .init(name: "Mystical time",
                                         mothersName: "Ann something",
                                         birthDate: "12/10/1980",
                                         sin: "000.000.00-23",
                                         userName: "We could never be together",
                                         address: "Avenue t's nice to pretend")
}

struct ResumeView: View {
    @StateObject private var viewModel: ResumeViewModel
    private var onContinue: () -> Void
    
    init(viewModel: ResumeViewModel,
         onContinue: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onContinue = onContinue
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Review You Information")
                    .font(AppTypography.screenTitle)
                    .foregroundStyle(Color.textPrimary)
                    .bold()
                
                Text("Please confirm that all the information below is correct before we continue.")
                    .foregroundStyle(Color.textSecondaryColor)
            }
            .padding(AppSpacing.medium)
            
            Spacer()
            
            VStack {
                ForEach(Array(viewModel.resumeList.enumerated()), id: \.element.id) { index, model in
                    ResumeListCell(model: model,
                                   hasDivider: index != viewModel.resumeList.count - 1
                    ) { selectedModel in
                        print("Change tapped:", selectedModel.description)
                    }
                }
            }
            .padding(AppSpacing.medium)
            .appCardSurface(
                radius: AppRadius.large,
                stroke: Color.border,
                shadow: AppShadow.card
            )
            .padding(.horizontal, AppSpacing.screenHorizontal)
            
            HStack {
                Circle()
                    .fill(Color.brandPrimaryColor.opacity(0.12))
                    .frame(width: 46, height: 46)
                    .overlay {
                        Image(systemName: "checkmark.shield")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundStyle(Color.brandPrimaryColor)
                    }
                
                Text("Your information is securely encrypted and will never be shared.")
                    .font(AppTypography.subheadline)
                    .foregroundStyle(Color.textSecondaryColor)
            }
            .padding(AppSpacing.medium)
            
            GlowButton(title: "Continue") {
                onContinue()
            }
            .padding(.vertical, AppSpacing.medium)
            
           
        }
        .task {
            await viewModel.load()
        }
        .background {
            Image("login-background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    ResumeView(viewModel: ResumeViewModel()) {
        print("Clicked")
    }
}
