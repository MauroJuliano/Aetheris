import AetherisDesignSystem
import Core
import SwiftUI
import UIKit

struct VirtualCardScreen: View {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var viewModel: VirtualCardViewModel
    @State private var isCardContentVisible = false
    @State private var isGenerateConfirmationPresented = false
    @State private var isCopyFeedbackVisible = false
    @State private var copyFeedbackTask: Task<Void, Never>?

    let onBackAction: () -> Void
    let onSettingsTap: () -> Void
    let onTransactionHistoryTap: (UUID) -> Void
    let onTransactionTap: (UUID) -> Void

    init(
        viewModel: VirtualCardViewModel,
        onBackAction: @escaping () -> Void,
        onSettingsTap: @escaping () -> Void = {},
        onTransactionHistoryTap: @escaping (UUID) -> Void = { _ in },
        onTransactionTap: @escaping (UUID) -> Void = { _ in }
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onBackAction = onBackAction
        self.onSettingsTap = onSettingsTap
        self.onTransactionHistoryTap = onTransactionHistoryTap
        self.onTransactionTap = onTransactionTap
    }

    var body: some View {
        VStack(spacing: 0) {
            navigationBar

            ZStack {
                if let errorMessage = viewModel.errorMessage, !viewModel.isLoading {
                    errorView(message: errorMessage)
                } else if let card = viewModel.displayedCard {
                    content(card: card, isLoading: viewModel.isLoading)
                } else {
                    emptyState
                }
            }
        }
        .appScreenBackground()
        .task {
            await viewModel.loadIfNeeded()
        }
        .onChange(of: scenePhase) { _, newPhase in
            guard newPhase != .active else { return }
            isCardContentVisible = false
        }
        .onDisappear {
            isCardContentVisible = false
            copyFeedbackTask?.cancel()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .confirmationDialog(
            Strings.VirtualCard.generateConfirmationTitle,
            isPresented: $isGenerateConfirmationPresented,
            titleVisibility: .visible
        ) {
            Button(Strings.VirtualCard.generateConfirmationAction, role: .destructive) {
                generateNewCardNumber()
            }

            Button(Strings.VirtualCard.cancel, role: .cancel) {}
        } message: {
            Text(Strings.VirtualCard.generateConfirmationMessage)
        }
        .overlay(alignment: .bottom) {
            copyFeedback
        }
        .accessibilityIdentifier("virtualCard.screen")
    }
}

#Preview {
    VirtualCardScreen(
        viewModel: VirtualCardViewModel(
            physicalCardId: CardsPreviewData.cardId,
            service: VirtualCardService(
                coreService: DemoCoreService(delay: 0)
            )
        ),
        onBackAction: {}
    )
}

private extension VirtualCardScreen {
    var navigationBar: some View {
        NavBar(
            hasNotifications: false,
            hasBackButton: true,
            model: .init(
                firstText: Strings.VirtualCard.title,
                hasInitialSpace: false
            ),
            onBack: onBackAction
        )
        .padding(.horizontal, AppSpacing.screenHorizontal)
        .padding(.bottom, AppSpacing.small)
    }

    func content(card: VirtualCardModel, isLoading: Bool) -> some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: AppSpacing.medium) {
                if isLoading {
                    SkeletonBlock(width: 280, height: 18, radius: 9)
                        .padding(.horizontal, AppSpacing.large)
                        .padding(.bottom, AppSpacing.xSmall)
                } else {
                    descriptionText
                }

                VirtualCardView(
                    model: card,
                    isContentVisible: isCardContentVisible,
                    onVisibilityTap: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isCardContentVisible.toggle()
                        }
                    }
                )
                .toSkeleton(enable: isLoading)

                VirtualCardQuickActions(
                    isGeneratingNewNumber: viewModel.isGeneratingNewNumber,
                    copyNumberTitle: Strings.VirtualCard.copyNumber,
                    generateNewNumberTitle: Strings.VirtualCard.generateNewNumber,
                    settingsTitle: Strings.VirtualCard.settings,
                    onCopyNumberTap: copyCardNumber,
                    onGenerateNewNumberTap: {
                        isGenerateConfirmationPresented = true
                    },
                    onSettingsTap: onSettingsTap
                )
                .toSkeleton(enable: isLoading)

                StatusToggleCard(
                    title: card.isActive ? Strings.VirtualCard.activeTitle : Strings.VirtualCard.inactiveTitle,
                    description: card.isActive ? Strings.VirtualCard.activeDescription : Strings.VirtualCard.inactiveDescription,
                    icon: card.isActive ? "checkmark.shield" : "lock.shield",
                    isOn: card.isActive,
                    isUpdating: viewModel.isUpdatingStatus,
                    onChange: { isActive in
                        Task {
                            await viewModel.updateCardStatus(isActive: isActive)
                        }
                    }
                )
                .toSkeleton(enable: isLoading)

                VirtualCardUsageSummary(
                    availableLimit: card.availableLimit,
                    totalLimit: card.totalLimit,
                    monthlyExpenses: card.monthlyExpenses,
                    usageProgress: card.usedLimitProgress,
                    monthlyUsagePercentage: card.monthlyUsagePercentage
                )
                .toSkeleton(enable: isLoading)

                summariesSection(isLoading: isLoading)

                VirtualCardSecurityInfo(
                    onLearnMoreTap: {
                        viewModel.showSecurityInformation()
                    }
                )
                .toSkeleton(enable: isLoading)
            }
            .padding(.horizontal, AppSpacing.screenHorizontal)
            .padding(.bottom, AppSpacing.large)
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear
                .frame(height: AppSpacing.bottomBarClearance)
        }
    }

    var descriptionText: some View {
        Text(Strings.VirtualCard.description)
            .font(AppTypography.body)
            .foregroundStyle(Color.textSecondaryColor)
            .multilineTextAlignment(.center)
            .padding(.horizontal, AppSpacing.large)
            .padding(.bottom, AppSpacing.xSmall)
    }

    func summariesSection(isLoading: Bool) -> some View {
        FinancialSummaryContainer(
            summaries: viewModel.summaries,
            title: Strings.VirtualCard.recentTransactions,
            actionTitle: Strings.VirtualCard.seeAll,
            onTap: openTransactionHistory,
            onActionTap: openTransactionHistory
        )
        .toSkeleton(enable: isLoading)
    }

    func openTransactionHistory() {
        guard let cardId = viewModel.virtualCard?.id else { return }
        onTransactionHistoryTap(cardId)
    }

    func errorView(message: String) -> some View {
        FeedbackView(
            title: Strings.VirtualCard.unavailableTitle,
            description: message,
            primaryButtonTitle: Strings.Common.tryAgain,
            onPrimaryAction: {
                Task {
                    await viewModel.load()
                }
            }
        )
    }

    var emptyState: some View {
        AppEmptyStateView(
            title: Strings.VirtualCard.emptyTitle,
            description: Strings.VirtualCard.emptyDescription,
            symbolName: "creditcard"
        )
    }

    @ViewBuilder
    var copyFeedback: some View {
        if isCopyFeedbackVisible {
            Text(Strings.VirtualCard.copied)
                .font(AppTypography.cellCaption)
                .bold()
                .foregroundStyle(Color.white)
                .padding(.horizontal, AppSpacing.medium)
                .padding(.vertical, AppSpacing.small)
                .background(Color.textPrimary)
                .clipShape(Capsule())
                .padding(.bottom, AppSpacing.large)
                .transition(.move(edge: .bottom).combined(with: .opacity))
        }
    }

    func copyCardNumber() {
        guard let cardNumber = viewModel.virtualCard?.cardNumber else { return }

        UIPasteboard.general.string = cardNumber
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        viewModel.didCopyCardNumber()

        copyFeedbackTask?.cancel()

        withAnimation {
            isCopyFeedbackVisible = true
        }

        copyFeedbackTask = Task { @MainActor in
            try? await Task.sleep(nanoseconds: 2_000_000_000)

            guard !Task.isCancelled else { return }

            withAnimation {
                isCopyFeedbackVisible = false
            }
        }
    }

    func generateNewCardNumber() {
        Task {
            await viewModel.generateNewCardNumber()
            isCardContentVisible = false
        }
    }
}
