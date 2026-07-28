import AetherisDesignSystem
import PaymentsInterface
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
                    VStack {
                        UserView(name: viewModel.profile.name)
                        
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
                            
                        FormView(cells: FormCellModel.notifications)
                        
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
                        
                        Text(Strings.Profile.version)
                            .foregroundStyle(Color.textTertiary.opacity(0.5))
                            .font(AppTypography.footnote)
                            .padding(.top, AppSpacing.medium)
                        
                        Text(Strings.Profile.poweredBy)
                            .foregroundStyle(Color.textTertiary.opacity(0.5))
                            .font(AppTypography.footnote)
                        
                        Button {
                            path.append(.terms)
                        } label: {
                            Text(Strings.Profile.terms)
                                .foregroundStyle(Color.brandPrimaryColor)
                                .font(AppTypography.button)
                        }
                        .padding(.bottom, AppSpacing.bottomBarClearance)
                    }
                }
                .opacity(viewModel.isLoading ? 0 : 1)

                ProfileScreenSkeleton()
                    .opacity(viewModel.isLoading ? 1 : 0)
            }
            .padding(.horizontal, AppSpacing.screenHorizontal)
            .appScreenBackground()
            .navigationDestination(for: ProfileRoute.self) { route in
                switch route {
                case .editName:
                    ProfileEditFieldView(
                        title: Strings.Profile.editNameTitle,
                        description: Strings.HomeApp.editNameDescription,
                        value: nameBinding,
                        placeholder: Strings.HomeApp.editNamePlaceholder
                    )
                case .editEmail:
                    ProfileEditFieldView(
                        title: Strings.Profile.editEmailTitle,
                        description: Strings.HomeApp.editEmailDescription,
                        value: emailBinding,
                        placeholder: Strings.HomeApp.editEmailPlaceholder
                    )
                case .editPhone:
                    ProfileEditFieldView(
                        title: Strings.Profile.editPhoneTitle,
                        description: Strings.HomeApp.editPhoneDescription,
                        value: phoneBinding,
                        placeholder: Strings.HomeApp.editPhonePlaceholder
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
        }
        .onAppear {
            syncTabBarVisibility()
        }
        .onChange(of: path.count) { _, _ in
            syncTabBarVisibility()
        }
        .task { await viewModel.load() }
    }

    private func syncTabBarVisibility() {
        tabBarVisibilityStore.isVisible = path.isEmpty
    }

    private var nameBinding: Binding<String> {
        Binding(
            get: { viewModel.profile.name },
            set: { viewModel.updateName($0) }
        )
    }

    private var emailBinding: Binding<String> {
        Binding(
            get: { viewModel.profile.email },
            set: { viewModel.updateEmail($0) }
        )
    }

    private var phoneBinding: Binding<String> {
        Binding(
            get: { viewModel.profile.phone },
            set: { viewModel.updatePhone($0) }
        )
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
