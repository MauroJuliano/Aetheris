import AetherisDesignSystem
import Core
import SwiftUI

struct TransactionHistoryView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: TransactionHistoryViewModel
    let onBack: (() -> Void)?
    let onTransactionTap: (UUID) -> Void

    init(
        viewModel: TransactionHistoryViewModel,
        onBack: (() -> Void)? = nil,
        onTransactionTap: @escaping (UUID) -> Void = { _ in }
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onBack = onBack
        self.onTransactionTap = onTransactionTap
    }

    var body: some View {
        ZStack {
            if let errorMessage = viewModel.errorMessage, !viewModel.isLoading {
                FeedbackView(
                    title: Strings.TransactionHistory.unavailableTitle,
                    description: errorMessage,
                    primaryButtonTitle: Strings.Common.tryAgain,
                    secondaryButtonTitle: Strings.Common.back,
                    onPrimaryAction: {
                        Task { await viewModel.load() }
                    },
                    onSecondaryAction: {
                        dismiss()
                    }
                )
            } else if viewModel.isEmpty && !viewModel.isLoading {
                AppEmptyStateView(
                    title: Strings.TransactionHistory.emptyTitle,
                    description: Strings.TransactionHistory.emptyDescription
                )
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: AppSpacing.xLarge) {
                        NavBar(
                            hasNotifications: false,
                            hasBackButton: true,
                            model: .init(
                                firstText: Strings.TransactionHistory.title,
                                hasInitialSpace: false
                            ),
                            onBack: {
                                if let onBack {
                                    onBack()
                                } else {
                                    dismiss()
                                }
                            }
                        )
                        .toSkeleton(enable: viewModel.isLoading)

                        ForEach(viewModel.displayedSections) { section in
                            VStack(alignment: .leading, spacing: AppSpacing.small) {
                                if viewModel.isLoading {
                                    SkeletonBlock(width: section.titleWidth, height: 18, radius: 9)
                                        .padding(.horizontal, AppSpacing.screenHorizontal)
                                } else {
                                    Text(section.title)
                                        .foregroundStyle(Color.textPrimary)
                                        .font(AppTypography.sectionTitle)
                                        .padding(.horizontal, AppSpacing.screenHorizontal)
                                }

                                VStack {
                                    ForEach(section.items) { transaction in
                                        Button {
                                            onTransactionTap(transaction.id)
                                        } label: {
                                            FinancialSummary(
                                                model: transaction,
                                                hasDivider: transaction.id != section.items.last?.id
                                            )
                                            .toSkeleton(enable: viewModel.isLoading)
                                            .frame(maxWidth: .infinity)
                                            .contentShape(Rectangle())
                                        }
                                        .buttonStyle(.plain)
                                        .accessibilityIdentifier("transactionHistory.row.\(transaction.id.uuidString)")
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
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .appScreenBackground()
        .task { await viewModel.load() }
    }

}

#Preview {
    TransactionHistoryView(
        viewModel: TransactionHistoryViewModel(
            service: TransactionHistoryService(
                coreService: DemoCoreService(delay: 0),
                cardId: CardsPreviewData.cardId
            )
        )
    )
}
