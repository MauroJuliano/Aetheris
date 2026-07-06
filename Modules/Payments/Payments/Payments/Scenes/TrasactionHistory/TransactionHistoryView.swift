import AetherisDesignSystem
import SwiftUI

struct TransactionHistoryView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = TransactionHistoryViewModel()
    @State private var isLoading = true

    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: AppSpacing.xLarge) {
                    NavBar(
                        hasNotifications: false,
                        hasBackButton: true,
                        model: .init(
                            firstText: "Transaction History",
                            hasInitialSpace: false
                        ),
                        onBack: { dismiss() }
                    )

                    ForEach(viewModel.sections) { section in
                        VStack(alignment: .leading, spacing: AppSpacing.small) {
                            Text(section.title)
                                .foregroundStyle(Color.textPrimary)
                                .font(AppTypography.sectionTitle)
                                .padding(.horizontal, AppSpacing.screenHorizontal)

                            VStack {
                                ForEach(section.items) { transaction in
                                    FinancialSummary(
                                        model: transaction,
                                        hasDivider: transaction.id != section.items.last?.id
                                    )
                                }
                            }
                            .appCardSurface(
                                radius: AppRadius.large,
                                stroke: Color.border,
                                shadow: AppShadow.card
                            )
                        }
                        .padding(.horizontal, AppSpacing.screenHorizontal)
                    }
                }
            }
            .opacity(isLoading ? 0 : 1)

            TransactionHistorySkeleton()
                .opacity(isLoading ? 1 : 0)
        }
        .navigationBarHidden(true)
        .appScreenBackground()
        .task {
            await viewModel.load()
            try? await Task.sleep(nanoseconds: 1_500_000_000)
            withAnimation(.easeOut(duration: 0.5)) {
                isLoading = false
            }
        }
    }
}

#Preview {
    TransactionHistoryView()
}
