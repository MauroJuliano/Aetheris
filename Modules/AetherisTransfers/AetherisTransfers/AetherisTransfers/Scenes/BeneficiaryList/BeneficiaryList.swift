import AetherisDesignSystem
import SwiftUI

struct BeneficiaryList: View {
    @StateObject private var viewModel: BeneficiaryListViewModel
    let onSelect: (Beneficiary) -> Void
    let onBack: () -> Void

    init(
        viewModel: BeneficiaryListViewModel,
        onSelect: @escaping (Beneficiary) -> Void,
        onBack: @escaping () -> Void
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onSelect = onSelect
        self.onBack = onBack
    }

    var body: some View {
        ZStack {
            VStack {
                NavBar(hasBackButton: true,
                       model: .init(firstText: "Beneficiaries", hasInitialSpace: false),
                       onBack: {
                    onBack()
                })

                ScrollView {
                    Spacer()
                        .frame(height: AppSpacing.bottomBarClearance / 2)

                    VStack {
                        ForEach(viewModel.beneficiaries) { cell in
                            BeneficiaryCell(model: cell,
                                            onChange: { selected in
                                onSelect(selected)
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
            .opacity(viewModel.isLoading ? 0 : 1)

            BeneficiaryListSkeleton()
                .opacity(viewModel.isLoading ? 1 : 0)
        }
        .padding(.horizontal, AppSpacing.screenHorizontal)
        .appScreenBackground()
        .task { await viewModel.load() }
    }
}

