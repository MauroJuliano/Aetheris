import AetherisDesignSystem
import AetherisAuthenticationInterface
import Core
import SwiftUI

struct ProfileScreen: View {
    @StateObject private var viewModel: ProfileScreenViewModel
    @State private var path: [ProfileRoute] = []
    @EnvironmentObject private var tabBarVisibilityStore: TabBarVisibilityStore

    init(viewModel: ProfileScreenViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: AppSpacing.medium) {
                        UserView(
                            name: viewModel.profile.name,
                            imageName: viewModel.profile.avatarName,
                            joinedDate: viewModel.profile.joinedDate
                        )

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
                            
                        FormView(cells: viewModel.notificationCells)
                        
                        Spacer()
                        
                        Button {
                            path.append(.logout)
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: AppRadius.large)
                                    .fill(Color.backgroundColorA)
                                    .appShadow(AppShadow.card)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: AppRadius.pill)
                                            .stroke(Color.border, style: .init(lineWidth: 1))
                                    )
                                    .frame(width: 300, height: 50)
                                
                                Text(Strings.Profile.logout)
                                    .foregroundStyle(Color.brandPrimaryColor)
                                    .font(AppTypography.button)
                                    .appShadow(AppShadow.control)
                            }
                        }
                        .padding(.vertical, AppSpacing.medium)
                        
                        Spacer()
                        
                        Text(viewModel.footer.version)
                            .foregroundStyle(Color.textTertiary.opacity(0.5))
                            .font(AppTypography.footnote)
                            .padding(.top, AppSpacing.medium)
                        
                        Text(viewModel.footer.poweredBy)
                            .foregroundStyle(Color.textTertiary.opacity(0.5))
                            .font(AppTypography.footnote)
                        
                        Button {
                            path.append(.terms)
                        } label: {
                            Text(viewModel.footer.terms)
                                .foregroundStyle(Color.brandPrimaryColor)
                                .font(AppTypography.button)
                        }
                        .padding(.bottom, AppSpacing.bottomBarClearance)
                    }
                }
                .opacity(viewModel.isInitialLoading ? 0 : 1)

                ProfileScreenSkeleton()
                    .opacity(viewModel.isInitialLoading ? 1 : 0)
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

private enum ProfileRoute: Hashable {
    case editName
    case editEmail
    case editPhone
    case feedback
    case terms
    case logout
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
