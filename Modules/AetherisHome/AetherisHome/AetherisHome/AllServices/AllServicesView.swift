import AetherisDesignSystem
import Core
import SwiftUI

struct AllServicesView: View {
    @StateObject private var viewModel: AllServicesViewModel
    let onBack: () -> Void
    let onSelect: (AllServicesItem.Route) -> Void

    init(
        viewModel: AllServicesViewModel,
        onBack: @escaping () -> Void,
        onSelect: @escaping (AllServicesItem.Route) -> Void
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onBack = onBack
        self.onSelect = onSelect
    }

    var body: some View {
        ZStack {
            if let errorMessage = viewModel.errorMessage, !viewModel.isLoading {
                FeedbackView(
                    title: Strings.HomeApp.genericErrorTitle,
                    description: errorMessage,
                    primaryButtonTitle: Strings.Common.tryAgain,
                    secondaryButtonTitle: Strings.Common.back,
                    onPrimaryAction: {
                        Task { await viewModel.load() }
                    },
                    onSecondaryAction: onBack
                )
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: AppSpacing.large) {
                        NavBar(
                            hasNotifications: false,
                            hasBackButton: true,
                            model: .init(
                                firstText: Strings.AllServices.title,
                                hasInitialSpace: false
                            ),
                            onBack: onBack
                        )
                        .toSkeleton(enable: viewModel.isLoading)

                        if viewModel.isLoading {
                            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                                SkeletonBlock(width: 140, height: 18, radius: 9)
                                SkeletonBlock(width: 240, height: 14, radius: 7)
                            }
                        } else {
                            Text(Strings.AllServices.subtitle)
                                .font(AppTypography.subheadline)
                                .foregroundStyle(Color.textSecondaryColor)
                                .padding(.top, -AppSpacing.small)
                        }

                        LazyVGrid(
                            columns: [
                                GridItem(.flexible(), spacing: AppSpacing.medium),
                        GridItem(.flexible(), spacing: AppSpacing.medium)
                    ],
                    spacing: AppSpacing.medium
                ) {
                    ForEach(viewModel.displayedItems) { item in
                        serviceCard(item: item, isLoading: viewModel.isLoading)
                    }
                }
            }
                    .padding(.horizontal, AppSpacing.screenHorizontal)
                    .padding(.bottom, AppSpacing.xxLarge)
                }
            }
        }
        .appScreenBackground()
        .animation(.easeInOut(duration: 0.25), value: viewModel.isLoading)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .task { await viewModel.load() }
    }

}

#Preview {
    AllServicesView(
        viewModel: AllServicesViewModel(
            service: AllServicesService(
                coreService: DemoCoreService(delay: 0)
            )
        ),
        onBack: {},
        onSelect: { _ in }
    )
}

private extension AllServicesView {
    func serviceCard(item: AllServicesItem, isLoading: Bool) -> some View {
        ServiceCard(
            title: item.title,
            subtitle: item.subtitle,
            icon: item.icon,
            accentColor: item.accentColor,
            action: {
                onSelect(item.route)
            }
        )
        .toSkeleton(enable: isLoading)
        .accessibilityIdentifier("allServices.\(item.route.rawValue)")
    }
}
