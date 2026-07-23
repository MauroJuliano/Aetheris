import AetherisDesignSystem
import SwiftUI

struct AllServicesView: View {
    @StateObject private var viewModel: AllServicesViewModel
    let onBack: () -> Void

    init(viewModel: AllServicesViewModel, onBack: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onBack = onBack
    }

    var body: some View {
        ZStack {
            if viewModel.isLoading {
                AllServicesSkeleton()
            } else if let errorMessage = viewModel.errorMessage {
                FullScreenErrorView(
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

                        Text(Strings.AllServices.subtitle)
                            .font(AppTypography.subheadline)
                            .foregroundStyle(Color.textSecondaryColor)
                            .padding(.top, -AppSpacing.small)

                        LazyVGrid(
                            columns: [
                                GridItem(.flexible(), spacing: AppSpacing.medium),
                                GridItem(.flexible(), spacing: AppSpacing.medium)
                            ],
                            spacing: AppSpacing.medium
                        ) {
                            ForEach(Array(viewModel.items.enumerated()), id: \.element.id) { index, item in
                                serviceCard(item: item, index: index)
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

    private func serviceCard(item: AllServicesItem, index: Int) -> some View {
        let background = backgroundColor(for: item.theme)
        let foreground = foregroundColor(for: item.theme)

        return VStack(alignment: .leading, spacing: AppSpacing.medium) {
            ZStack {
                RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                    .fill(background.opacity(0.12))
                    .frame(width: 44, height: 44)

                Image(systemName: item.icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(foreground)
            }

            Text(item.title)
                .font(AppTypography.headline)
                .foregroundStyle(Color.textPrimary)
                .lineLimit(2)

            Text(item.subtitle)
                .font(AppTypography.footnote)
                .foregroundStyle(Color.textSecondaryColor)
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity, minHeight: 132, alignment: .leading)
        .padding(AppSpacing.medium)
        .appCardSurface(
            radius: AppRadius.large,
            stroke: Color.border,
            shadow: AppShadow.card
        )
    }

    private func backgroundColor(for theme: AllServicesItem.Theme) -> Color {
        switch theme {
        case .primary: return .brandPrimaryColor
        case .success: return .success
        case .info: return .blue
        case .warning: return .orange
        }
    }

    private func foregroundColor(for theme: AllServicesItem.Theme) -> Color {
        switch theme {
        case .primary: return .brandPrimaryColor
        case .success: return .success
        case .info: return .blue
        case .warning: return .orange
        }
    }
}
