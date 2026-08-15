import AetherisDesignSystem
import Core
import SwiftUI

struct CardLockScreen: View {
    @StateObject private var viewModel: CardLockViewModel
    @State private var isConfirmationPresented = false

    let onBackAction: () -> Void
    let onHelpTap: () -> Void
    let onCardSettingsTap: (UUID) -> Void
    let onVirtualCardTap: (UUID) -> Void
    let onRequestNewCardTap: (UUID) -> Void

    init(
        viewModel: CardLockViewModel,
        onBackAction: @escaping () -> Void,
        onHelpTap: @escaping () -> Void = {},
        onCardSettingsTap: @escaping (UUID) -> Void = { _ in },
        onVirtualCardTap: @escaping (UUID) -> Void = { _ in },
        onRequestNewCardTap: @escaping (UUID) -> Void = { _ in }
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onBackAction = onBackAction
        self.onHelpTap = onHelpTap
        self.onCardSettingsTap = onCardSettingsTap
        self.onVirtualCardTap = onVirtualCardTap
        self.onRequestNewCardTap = onRequestNewCardTap
    }

    var body: some View {
        VStack(spacing: 0) {
            navigationBar

            ZStack {
                if viewModel.isLoading {
                    CardLockScreenSkeleton()
                } else if let errorMessage = viewModel.errorMessage {
                    errorView(message: errorMessage)
                } else if let card = viewModel.card {
                    content(card)
                } else {
                    emptyState
                }
            }
        }
        .appScreenBackground()
        .task {
            await viewModel.loadIfNeeded()
        }
        .confirmationDialog(
            confirmationTitle,
            isPresented: $isConfirmationPresented,
            titleVisibility: .visible
        ) {
            Button(
                confirmationButtonTitle,
                role: viewModel.card?.isBlocked == true ? nil : .destructive
            ) {
                updateCardStatus()
            }

            Button(Strings.Common.cancel, role: .cancel) {}
        } message: {
            Text(confirmationDescription)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .accessibilityIdentifier("cardLock.screen")
    }
}

#Preview {
    CardLockScreen(
        viewModel: CardLockViewModel(
            cardId: CardsPreviewData.cardId,
            service: CardLockService(
                coreService: DemoCoreService(delay: 0)
            )
        ),
        onBackAction: {}
    )
}

private extension CardLockScreen {
    var navigationBar: some View {
        NavBar(
            hasNotifications: false,
            hasBackButton: true,
            model: .init(
                firstText: navigationTitle,
                hasInitialSpace: false
            ),
            onBack: onBackAction
        )
        .padding(.bottom, AppSpacing.small)
    }

    var navigationTitle: String {
        guard let card = viewModel.card else {
            return Strings.CardLock.title
        }

        return card.isBlocked ? Strings.CardLock.unlockTitle : Strings.CardLock.lockTitle
    }

    func content(_ card: CardLockModel) -> some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: AppSpacing.medium) {
                descriptionText(card)

                CardLockPreview(model: card)

                CardLockStatusMessage(isBlocked: card.isBlocked)

                CardLockEffectsSection(isBlocked: card.isBlocked)

                primaryActionButton(card)

                otherOptionsSection(card)

                CardLockSecurityMessage()
            }
            .padding(.horizontal, AppSpacing.screenHorizontal)
            .padding(.bottom, AppSpacing.large)
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear
                .frame(height: AppSpacing.bottomBarClearance)
        }
    }

    func descriptionText(_ card: CardLockModel) -> some View {
        Text(card.isBlocked ? Strings.CardLock.blockedDescription : Strings.CardLock.unblockedDescription)
            .font(AppTypography.body)
            .foregroundStyle(Color.textSecondaryColor)
            .multilineTextAlignment(.center)
            .padding(.horizontal, AppSpacing.large)
            .padding(.bottom, AppSpacing.xSmall)
    }

    func primaryActionButton(_ card: CardLockModel) -> some View {
        Button {
            isConfirmationPresented = true
        } label: {
            HStack(spacing: AppSpacing.small) {
                if viewModel.isUpdatingStatus {
                    ProgressView()
                        .tint(Color.white)
                } else {
                    Image(systemName: card.isBlocked ? "lock.open.fill" : "lock.fill")
                        .font(.system(size: 18, weight: .semibold))
                }

                Text(card.isBlocked ? Strings.CardLock.unlockCard : Strings.CardLock.lockCard)
                    .font(AppTypography.body)
                    .bold()
            }
            .foregroundStyle(Color.white)
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .background(primaryActionColor(card))
            .clipShape(RoundedRectangle(cornerRadius: AppRadius.large))
        }
        .buttonStyle(.plain)
        .disabled(viewModel.isUpdatingStatus)
        .opacity(viewModel.isUpdatingStatus ? 0.7 : 1)
        .accessibilityIdentifier("cardLock.primaryAction")
    }

    func primaryActionColor(_ card: CardLockModel) -> Color {
        card.isBlocked ? Color.success : Color.error
    }

    func otherOptionsSection(_ card: CardLockModel) -> some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text(Strings.CardLock.otherOptions)
                .font(AppTypography.body)
                .bold()
                .foregroundStyle(Color.textPrimary)

            VStack(spacing: 0) {
                CardLockOptionRow(
                    title: Strings.CardLock.cardSettings,
                    description: Strings.CardLock.cardSettingsDescription,
                    icon: "gearshape"
                ) {
                    onCardSettingsTap(card.id)
                }

                Divider()
                    .padding(.leading, 72)

                CardLockOptionRow(
                    title: Strings.CardLock.virtualCard,
                    description: Strings.CardLock.virtualCardDescription,
                    icon: "creditcard"
                ) {
                    onVirtualCardTap(card.id)
                }

                Divider()
                    .padding(.leading, 72)

                CardLockOptionRow(
                    title: Strings.CardLock.requestNewCard,
                    description: Strings.CardLock.requestNewCardDescription,
                    icon: "creditcard.and.123"
                ) {
                    onRequestNewCardTap(card.id)
                }
            }
            .appCardSurface()
        }
    }

    var confirmationTitle: String {
        guard let card = viewModel.card else { return "" }
        return card.isBlocked ? Strings.CardLock.unlockConfirmationTitle : Strings.CardLock.lockConfirmationTitle
    }

    var confirmationButtonTitle: String {
        guard let card = viewModel.card else { return "" }
        return card.isBlocked ? Strings.CardLock.unlockCard : Strings.CardLock.lockCard
    }

    var confirmationDescription: String {
        guard let card = viewModel.card else { return "" }
        return card.isBlocked ? Strings.CardLock.unlockConfirmationDescription : Strings.CardLock.lockConfirmationDescription
    }

    func updateCardStatus() {
        Task {
            await viewModel.toggleCardStatus()
        }
    }

    func errorView(message: String) -> some View {
        FeedbackView(
            title: Strings.CardLock.unavailableTitle,
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
            title: Strings.CardLock.emptyTitle,
            description: Strings.CardLock.emptyDescription,
            symbolName: "creditcard.trianglebadge.exclamationmark"
        )
    }
}

private struct CardLockOptionRow: View {
    let title: String
    let description: String
    let icon: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: AppSpacing.medium) {
                ZStack {
                    Circle()
                        .fill(Color.brandPrimaryColor.opacity(0.08))
                        .frame(width: 42, height: 42)

                    Image(systemName: icon)
                        .font(.system(size: 17, weight: .medium))
                        .foregroundStyle(Color.brandPrimaryColor)
                }

                VStack(alignment: .leading, spacing: AppSpacing.xxxSmall) {
                    Text(title)
                        .font(AppTypography.body)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.textPrimary)

                    Text(description)
                        .font(AppTypography.cellCaption)
                        .foregroundStyle(Color.textSecondaryColor)
                        .multilineTextAlignment(.leading)
                }

                Spacer(minLength: AppSpacing.small)

                Image(systemName: "chevron.right")
                    .font(.caption.bold())
                    .foregroundStyle(Color.textTertiary)
            }
            .padding(.horizontal, AppSpacing.medium)
            .padding(.vertical, AppSpacing.small)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
