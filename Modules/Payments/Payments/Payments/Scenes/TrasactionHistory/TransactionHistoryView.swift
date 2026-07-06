import AetherisDesignSystem
import SwiftUI

struct TransactionHistoryView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = TransactionHistoryViewModel()
    @State private var isLoading = true

    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
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
                        VStack(alignment: .leading, spacing: 12) {
                            Text(section.title)
                                .foregroundStyle(.black)
                                .font(.headline)
                                .padding(.horizontal)

                            VStack {
                                ForEach(section.items) { transaction in
                                    FinancialSummary(
                                        model: transaction,
                                        hasDivider: transaction.id != section.items.last?.id
                                    )
                                }
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.backgroundColorA)
                                    .shadow(color: .gray.opacity(0.25), radius: 16, y: 5)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(.gray.opacity(0.25), lineWidth: 1)
                                    )
                            )
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .opacity(isLoading ? 0 : 1)

            TransactionHistorySkeleton()
                .opacity(isLoading ? 1 : 0)
        }
        .navigationBarHidden(true)
        .background(Color.backgroundColorA)
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
