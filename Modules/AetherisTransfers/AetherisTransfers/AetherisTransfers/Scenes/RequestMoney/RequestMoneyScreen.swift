import AetherisDesignSystem
import Core
import SwiftUI

struct RequestMoneyScreen: View {
    @StateObject private var viewModel: RequestMoneyViewModel
    @FocusState private var focusedField: RequestMoneyField?

    let onBackAction: () -> Void
    let onHelpTap: () -> Void
    let onContactSearchTap: () -> Void
    let onShareRequestTap: () -> Void
    let onSuccess: (MoneyRequestModel) -> Void

    init(
        viewModel: RequestMoneyViewModel,
        onBackAction: @escaping () -> Void,
        onHelpTap: @escaping () -> Void = {},
        onContactSearchTap: @escaping () -> Void = {},
        onShareRequestTap: @escaping () -> Void = {},
        onSuccess: @escaping (MoneyRequestModel) -> Void = { _ in }
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)

        self.onBackAction = onBackAction
        self.onHelpTap = onHelpTap
        self.onContactSearchTap = onContactSearchTap
        self.onShareRequestTap = onShareRequestTap
        self.onSuccess = onSuccess
    }

    var body: some View {
        VStack(spacing: 0) {
            navigationBar

            ZStack {
                if viewModel.isLoading {
                    RequestMoneyScreenSkeleton()
                } else if let errorMessage = viewModel.loadingErrorMessage {
                    loadingErrorView(message: errorMessage)
                } else {
                    content
                }
            }
        }
        .appScreenBackground()
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .task {
            await viewModel.loadIfNeeded()
        }
        .alert(
            Strings.RequestMoney.errorTitle,
            isPresented: submitErrorBinding
        ) {
            Button(Strings.Common.ok, role: .cancel) {
                viewModel.dismissSubmitError()
            }
        } message: {
            if let message = viewModel.submitErrorMessage {
                Text(message)
            }
        }
        .accessibilityIdentifier("requestMoney.screen")
    }
}

private extension RequestMoneyScreen {
    var navigationBar: some View {
        NavBar(
            hasBackButton: true,
            model: .init(
                firstText: Strings.RequestMoney.title,
                hasInitialSpace: false
            ),
            onBack: onBackAction
        )
        .padding(.horizontal, AppSpacing.screenHorizontal)
        .padding(.bottom, AppSpacing.small)
    }
}

private extension RequestMoneyScreen {
    var content: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: AppSpacing.medium) {
                descriptionText

                RequestMoneyModeSelector(
                    selectedMode: viewModel.selectedMode,
                    onModeSelected: viewModel.selectMode
                )

                switch viewModel.selectedMode {
                case .contact:
                    requestForm
                case .shareLink:
                    sharedRequestContent
                }
            }
            .padding(.horizontal, AppSpacing.screenHorizontal)
            .padding(.bottom, AppSpacing.large)
        }
        .safeAreaInset(edge: .bottom) {
            bottomAction
        }
        .scrollDismissesKeyboard(.interactively)
    }

    var descriptionText: some View {
        Text(Strings.RequestMoney.description)
            .font(AppTypography.body)
            .foregroundStyle(Color.textSecondaryColor)
            .multilineTextAlignment(.center)
            .padding(.horizontal, AppSpacing.large)
            .padding(.bottom, AppSpacing.xSmall)
    }

    var requestForm: some View {
        Group {
            RequestMoneyFormCard(
                contacts: viewModel.recentContacts,
                selectedContact: viewModel.selectedContact,
                presets: viewModel.amountPresets,
                amountText: $viewModel.amountText,
                reason: $viewModel.reason,
                focusedField: $focusedField,
                onSearchTap: onContactSearchTap,
                onContactTap: viewModel.selectContact,
                onPresetTap: viewModel.selectPreset
            )

            if viewModel.selectedContact != nil,
               viewModel.amount > 0 {
                preview
            }
        }
    }

    var sharedRequestContent: some View {
        Group {
            SharedMoneyRequestCard(
                presets: viewModel.amountPresets,
                amountText: $viewModel.amountText,
                reason: $viewModel.reason,
                focusedField: $focusedField,
                onPresetTap: viewModel.selectPreset
            )

            if viewModel.amount > 0 {
                preview
            }
        }
    }

    var preview: some View {
        RequestMoneyPreview(
            contact: viewModel.selectedContact,
            requesterName: viewModel.requesterName,
            amount: viewModel.amount,
            reason: viewModel.normalizedReason,
            mode: viewModel.selectedMode
        )
        .transition(.move(edge: .bottom).combined(with: .opacity))
    }
}

private extension RequestMoneyScreen {
    var bottomAction: some View {
        PrimaryButton(title: primaryButtonTitle) {
            focusedField = nil
            submitRequest()
        }
        .disabled(!viewModel.canSubmit)
        .opacity(viewModel.canSubmit ? 1 : 0.45)
        .padding(.horizontal, AppSpacing.screenHorizontal)
        .padding(.top, AppSpacing.small)
        .padding(.bottom, AppSpacing.small)
        .background(Color.backgroundColorA)
        .accessibilityIdentifier("requestMoney.submitButton")
    }

    var primaryButtonTitle: String {
        switch viewModel.selectedMode {
        case .contact:
            return Strings.RequestMoney.sendRequest
        case .shareLink:
            return Strings.RequestMoney.shareRequest
        }
    }

    func submitRequest() {
        Task {
            guard let request = await viewModel.submit() else {
                return
            }

            if viewModel.selectedMode == .shareLink {
                onShareRequestTap()
            }

            onSuccess(request)
        }
    }
}

private extension RequestMoneyScreen {
    var submitErrorBinding: Binding<Bool> {
        Binding(
            get: {
                viewModel.submitErrorMessage != nil
            },
            set: { isPresented in
                if !isPresented {
                    viewModel.dismissSubmitError()
                }
            }
        )
    }

    func loadingErrorView(message: String) -> some View {
        FeedbackView(
            title: Strings.RequestMoney.unavailableTitle,
            description: message,
            primaryButtonTitle: Strings.Common.tryAgain,
            onPrimaryAction: {
                Task {
                    await viewModel.load()
                }
            }
        )
    }
}
