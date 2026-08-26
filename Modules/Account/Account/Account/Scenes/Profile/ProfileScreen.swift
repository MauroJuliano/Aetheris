import AetherisDesignSystem
import AetherisAuthenticationInterface
import Core
import SwiftUI

struct ProfileScreen: View {
    @StateObject private var viewModel: ProfileScreenViewModel
    @State private var path: [ProfileRoute] = []
    @EnvironmentObject private var tabBarVisibilityStore: TabBarVisibilityStore
    private let languageManager: any LanguageManaging

    init(
        viewModel: ProfileScreenViewModel,
        languageManager: any LanguageManaging = LanguageManager()
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.languageManager = languageManager
    }

    var body: some View {
        NavigationStack(path: $path) {
            ScrollView(showsIndicators: false) {
                    VStack(spacing: AppSpacing.medium) {
                        UserView(
                            name: viewModel.profile.name,
                            imageName: viewModel.profile.avatarName,
                            joinedDate: viewModel.profile.joinedDate
                        )
                        .toSkeleton(enable: viewModel.isInitialLoading)

                        if viewModel.hasLoadingError {
                            ProfileLoadErrorView(
                                isRetrying: viewModel.isRetrying,
                                onRetry: {
                                    Task { await viewModel.retry() }
                                }
                            )
                            .transition(.move(edge: .top).combined(with: .opacity))
                        }

                        FormView(cells: viewModel.generalCells) { cell in
                            switch cell.content.kind {
                            case .name:
                                path.append(.editName)
                            case .email:
                                path.append(.editEmail)
                            case .phone:
                                path.append(.editPhone)
                            case .feedback:
                                path.append(.feedback)
                            default:
                                break
                            }
                        }
                        .toSkeleton(enable: viewModel.isInitialLoading)

                        FormView(cells: viewModel.notificationCells)
                            .toSkeleton(enable: viewModel.isInitialLoading)

                        LanguagePreferenceRow(
                            title: Strings.Language.title,
                            value: languageManager.currentLanguage.title,
                            onTap: { path.append(.language) }
                        )
                        .toSkeleton(enable: viewModel.isInitialLoading)
                        .accessibilityIdentifier("profile.languageButton")

                        PrimaryButton(title: Strings.Profile.logout) { path.append(.logout) }
                        .toSkeleton(enable: viewModel.isInitialLoading)
                        .frame(width: 300)
                        .padding(.vertical, AppSpacing.medium)

                        ProfileFooterView(footer: viewModel.footer) { path.append(.terms) }
                            .toSkeleton(enable: viewModel.isInitialLoading)
                    }
                    .padding(.bottom, AppSpacing.bottomBarClearance)
            }
            .padding(.horizontal, AppSpacing.screenHorizontal)
            .appScreenBackground()
            .navigationDestination(for: ProfileRoute.self) { route in
                switch route {
                case .editName:
                    ProfileEditFieldView(
                        title: Strings.Profile.editNameTitle,
                        description: Strings.Profile.editNameDescription,
                        initialValue: viewModel.profile.name,
                        placeholder: Strings.Profile.editNamePlaceholder,
                        onSave: viewModel.updateName
                    )
                case .editEmail:
                    ProfileEditFieldView(
                        title: Strings.Profile.editEmailTitle,
                        description: Strings.Profile.editEmailDescription,
                        initialValue: viewModel.profile.email,
                        placeholder: Strings.Profile.editEmailPlaceholder,
                        onSave: viewModel.updateEmail
                    )
                case .editPhone:
                    ProfileEditFieldView(
                        title: Strings.Profile.editPhoneTitle,
                        description: Strings.Profile.editPhoneDescription,
                        initialValue: viewModel.profile.phone,
                        placeholder: Strings.Profile.editPhonePlaceholder,
                        onSave: viewModel.updatePhone
                    )
                case .feedback:
                    ProfileFeedbackView {
                        path.removeLast()
                    }
                case .terms:
                    ProfileLegalView {
                        path.removeLast()
                    }
                case .logout:
                    ProfileLogoutView()
                case .language:
                    LanguageSelectionView(languageManager: languageManager)
                }
            }
            .animation(.easeInOut(duration: 0.25), value: viewModel.hasLoadingError)
        }
        .onAppear {
            syncTabBarVisibility()
        }
        .onChange(of: path.count) { _, _ in
            syncTabBarVisibility()
        }
        .task { await viewModel.load() }
        .accessibilityIdentifier("profile.screen")
    }

    private func syncTabBarVisibility() {
        tabBarVisibilityStore.isVisible = path.isEmpty
    }

}

private struct ProfileFooterView: View {
    let footer: ProfileDashboardResponse.Footer
    let onTermsTap: () -> Void

    var body: some View {
        VStack(spacing: AppSpacing.small) {
            Text(footer.version).foregroundStyle(Color.textTertiary.opacity(0.5)).font(AppTypography.footnote)
            Text(footer.poweredBy).foregroundStyle(Color.textTertiary.opacity(0.5)).font(AppTypography.footnote)
            Button(footer.terms, action: onTermsTap).foregroundStyle(Color.brandPrimaryColor).font(AppTypography.button)
        }
        .padding(.top, AppSpacing.medium)
    }

    @ViewBuilder
    func toSkeleton(enable: Bool) -> some View {
        if enable {
            VStack(spacing: AppSpacing.small) {
                SkeletonBlock(width: 88, height: 12, radius: 6)
                SkeletonBlock(width: 140, height: 12, radius: 6)
                SkeletonBlock(width: 210, height: 18, radius: 9)
            }
        } else { self }
    }
}

private enum ProfileRoute: Hashable {
    case editName
    case editEmail
    case editPhone
    case feedback
    case terms
    case logout
    case language
}

#Preview {
    ProfileScreen(
        viewModel: ProfileScreenViewModel(
            store: ProfileStore(),
            service: ProfileService(
                coreService: DemoCoreService(delay: 0)
            )
        )
    )
    .environmentObject(TabBarVisibilityStore())
}
