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
            if let errorMessage = viewModel.errorMessage {
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
                notificationsContent
            }
        }
        .navigationBarHidden(true)
        .appScreenBackground()
        .task { await viewModel.load() }
    }
}

private extension NotificationsCentre {
    var notificationsContent: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: AppSpacing.xLarge) {
                navBar

                ForEach(viewModel.sections) { section in
                    sectionView(model: section)
                }
            }
        }
    }

    var navBar: some View {
        NavBar(
            hasNotifications: false,
            hasBackButton: true,
            model: .init(
                firstText: Strings.NotificationsCentre.title,
                hasInitialSpace: false
            ),
            onBack: onBack
        )
    }

    func sectionView(
        model: NotificationsSectionPresentationModel
    ) -> some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            NotificationSectionHeader(
                title: model.title,
                skeletonWidth: model.titleSkeletonWidth
            )
            .toSkeleton(enable: model.isLoading)
            .padding(.horizontal, AppSpacing.screenHorizontal)

            VStack(spacing: 0) {
                ForEach(Array(model.items.enumerated()), id: \.element.id) { index, item in
                    NotificationCell(
                        model: item
                    )
                    .toSkeleton(enable: model.isLoading)

                    if model.isLoading == false, index < model.items.count - 1 {
                        Divider()
                            .padding(.leading, 62)
                    }
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

#Preview {
    NotificationsCentre(
        viewModel: NotificationsCentreViewModel(
            service: NotificationsCentreService(
                coreService: DemoCoreService(delay: 0)
            )
        ),
        onBack: {}
    )
}
