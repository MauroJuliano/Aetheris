import AetherisDesignSystem
import SwiftUI

struct BeneficiaryList: View {
    @Binding var showSelection: Bool
    @State var model: [Beneficiary]
    @State private var isLoading = true
    var onSelect: (Beneficiary) -> Void
    
    var body: some View {
        ZStack {
            VStack {
                NavBar(hasBackButton: true,
                       model: .init(firstText: "Beneficiaries", hasInitialSpace: false),
                       onBack: {
                    showSelection = false
                })
                
                ScrollView {
                    Spacer()
                        .frame(height: AppSpacing.bottomBarClearance / 2)
                    
                    VStack {
                        ForEach(model) { cell in
                            BeneficiaryCell(model: cell,
                                            onChange: { selected in
                                onSelect(selected)
                                showSelection = false
                            })
                                .padding(.horizontal)
                        }
                    }
                    .appCardSurface(
                        radius: AppRadius.large,
                        stroke: Color.border,
                        shadow: AppShadow.card
                    )
                    
                }
                .appScreenBackground()
            }
            .opacity(isLoading ? 0 : 1)

            BeneficiaryListSkeleton()
                .opacity(isLoading ? 1 : 0)
        }
        .padding(.horizontal, AppSpacing.screenHorizontal)
        .appScreenBackground()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeOut(duration: 0.5)) {
                    isLoading = false
                }
            }
        }

    }
}

#Preview {
    BeneficiaryList(showSelection: .constant(true),
                    model: Beneficiary.beneficiaries,
                    onSelect: { selected in
        print(selected)
    })
}
