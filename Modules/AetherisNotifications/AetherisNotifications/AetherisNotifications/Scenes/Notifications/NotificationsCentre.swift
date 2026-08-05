import AetherisDesignSystem
import Core
import SwiftUI

struct NotificationsCentre: View {
    @StateObject private var viewModel: NotificationsCentreViewModel
    let onBack: () -> Void

    init(viewModel: NotificationsCentreViewModel,
         onBack: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onBack = onBack
    }

    var body: some View {
        ZStack {
            if viewModel.isLoading {
                NotificationsCentreSkeleton()
            } else if let errorMessage = viewModel.errorMessage {
                FeedbackView(
                    title: Strings.NotificationsCentre.unavailableTitle,
                    description: errorMessage,
                    primaryButtonTitle: Strings.Common.tryAgain,
                    secondaryButtonTitle: Strings.Common.back,
                    onPrimaryAction: {
                        Task { await viewModel.load() }
                    },
                    onSecondaryAction: onBack
                )
            } else if viewModel.isEmpty {
                AppEmptyStateView(
                    title: Strings.NotificationsCentre.emptyTitle,
                    description: Strings.NotificationsCentre.emptyDescription
                )
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: AppSpacing.xLarge) {

                        NavBar(
                            hasNotifications: false,
                            hasBackButton: true,
                            model: .init(
                                firstText: Strings.NotificationsCentre.title,
                                hasInitialSpace: false
                            ),
                            onBack: onBack
                        )

                        ForEach(viewModel.sections) { section in
                            VStack(alignment: .leading, spacing: AppSpacing.small) {

                                Text(section.title)
                                    .foregroundStyle(Color.textPrimary)
                                    .font(AppTypography.sectionTitle)
                                    .padding(.horizontal, AppSpacing.screenHorizontal)

                                VStack {
                                    ForEach(section.items) { cell in
                                        NotificationCell(model: cell)
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
        .appScreenBackground()
        .task { await viewModel.load() }
    }
}
