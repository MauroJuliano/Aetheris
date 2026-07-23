import AetherisDesignSystem
import Core
import PaymentsInterface
import UIKit
import SwiftUI

private enum HomeAppRoute: Hashable {
    case card
    case transactionHistory
    case sendMoney
    case sendMoneyBeneficiaryList
    case sendMoneyPin
    case sendMoneyProcessing
    case sendMoneySuccess
    case beneficiaryList
    case addBeneficiary
    case notifications
    case allServices
    case insurance
    case viewReport
}

struct HomeApp: View {
    @StateObject private var viewModel: HomeAppViewModel
    let coreService: any HasCoreService
    @Binding private var selectedBeneficiary: Beneficiary
    @State private var path: [HomeAppRoute] = []
    @State private var transferReceipt: TransferReceiptModel?
    @EnvironmentObject private var tabBarVisibilityStore: TabBarVisibilityStore

    init(
        viewModel: HomeAppViewModel,
        coreService: any HasCoreService,
        selectedBeneficiary: Binding<Beneficiary>
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.coreService = coreService
        _selectedBeneficiary = selectedBeneficiary
    }

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Image("login-background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                if viewModel.isLoading {
                    HomeAppSkeleton()
                } else if let errorMessage = viewModel.errorMessage {
                    FullScreenErrorView(
                        title: Strings.HomeApp.homeUnavailableTitle,
                        description: errorMessage,
                        primaryButtonTitle: Strings.Common.tryAgain,
                        onPrimaryAction: {
                            Task { await viewModel.load() }
                        }
                    )
                } else if viewModel.isEmpty {
                    PaymentsEmptyStateView(
                        title: Strings.HomeApp.noDashboardDataTitle,
                        description: Strings.HomeApp.emptyDescription
                    )
                } else {
                    ScrollView(showsIndicators: false) {
                        NavBar(
                            model: .init(
                                firstText: Strings.HomeApp.welcomePrefix,
                                secondText: Strings.HomeApp.welcomeName,
                                hasInitialSpace: false
                            ),
                            onRightButtonAction: {
                                path.append(.notifications)
                            }
                        )

                        BalanceView()

                        CardSwipe(cards: $viewModel.cards, onTap: {
                            path.append(.card)
                        })

                        RecipientsContainer(
                            onSelectRecipient: { beneficiary in
                                selectedBeneficiary = beneficiary
                                path.append(.sendMoney)
                            },
                            onSeeAllTap: {
                                path.append(.beneficiaryList)
                            },
                            onNewRecipientTap: {
                                path.append(.addBeneficiary)
                            }
                        )

                        QuickActions(
                            onTransferTap: {
                                selectedBeneficiary = .beneficiaries.first!
                                path.append(.sendMoney)
                            },
                            onMoreTap: {
                                withAnimation(.easeInOut(duration: 0.25)) {
                                    path.append(.allServices)
                                }
                            }
                        )

                        SpendingThisMonthView(
                            onViewReportTap: {
                                path.append(.viewReport)
                            }
                        )
                    }
                    .padding(.horizontal, AppSpacing.screenHorizontal)
                    .safeAreaInset(edge: .bottom) {
                        Color.clear
                            .frame(height: AppSpacing.bottomBarClearance)
                    }
                }
            }
            .navigationDestination(for: HomeAppRoute.self) { route in
                switch route {
                case .card:
                    HomeCardFactory.make(
                        coreService: coreService,
                        onBackAction: { pop() },
                        onTransactionHistoryTap: {
                            path.append(.transactionHistory)
                        }
                    )
                    .navigationBarHidden(true)

                case .transactionHistory:
                    TransactionHistoryFactory.make(
                        coreService: coreService,
                        onBack: { pop() }
                    )

                case .sendMoney:
                    SendMoneyFactory.make(
                        selectedBeneficiary: $selectedBeneficiary,
                        onBackAction: { pop() },
                        onChangeBeneficiary: {
                            path.append(.sendMoneyBeneficiaryList)
                        },
                        onContinue: { receipt in
                            transferReceipt = receipt
                            path.append(.sendMoneyPin)
                        }
                    )
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                    .toolbar(.hidden, for: .navigationBar)

                case .sendMoneyBeneficiaryList:
                    BeneficiaryListFactory.make(
                        onSelect: { beneficiary in
                            selectedBeneficiary = beneficiary
                            pop()
                        },
                        onBack: { pop() }
                    )
                    .navigationBarHidden(true)

                case .sendMoneyPin:
                    if let receipt = transferReceipt {
                        TransferPinFactory.make(
                            receipt: receipt,
                            onBack: { pop() },
                            onValidPin: {
                                path.append(.sendMoneyProcessing)
                            }
                        )
                        .navigationBarHidden(true)
                    } else {
                        EmptyView()
                    }

                case .sendMoneyProcessing:
                    if let receipt = transferReceipt {
                        TransferProcessingFactory.make(
                            receipt: receipt,
                            onCompleted: {
                                replaceCurrentRoute(with: .sendMoneySuccess)
                            }
                        )
                        .navigationBarHidden(true)
                    } else {
                        EmptyView()
                    }

                case .sendMoneySuccess:
                    if let receipt = transferReceipt {
                        TransferSuccessFactory.make(
                            model: receipt,
                            onBack: { pop() },
                            onDone: {
                                path.removeAll()
                                transferReceipt = nil
                            },
                            onNewTransfer: {
                                transferReceipt = nil
                                path.removeAll()
                            },
                            onCopyReference: { reference in
                                UIPasteboard.general.string = reference
                            }
                        )
                        .navigationBarHidden(true)
                    } else {
                        EmptyView()
                    }

                case .beneficiaryList:
                    BeneficiaryListFactory.make(
                        onSelect: { beneficiary in
                            selectedBeneficiary = beneficiary
                            replaceCurrentRoute(with: .sendMoney)
                        },
                        onBack: { pop() }
                    )
                    .navigationBarHidden(true)

                case .addBeneficiary:
                    BeneficiaryAddFactory.make(
                        coreService: coreService,
                        onBack: { pop() },
                        onComplete: { beneficiary in
                            selectedBeneficiary = beneficiary
                            replaceCurrentRoute(with: .sendMoney)
                        }
                    )
                    .navigationBarHidden(true)

                case .notifications:
                    NotificationsCentreFactory.make(
                        coreService: coreService,
                        onBack: { pop() }
                    )
                    .navigationBarHidden(true)

                case .allServices:
                    AllServicesFactory.make(
                        coreService: coreService,
                        onBack: { pop() }
                    )

                case .insurance:
                    InsuranceOnboardingFactory.make(coreService: coreService)
                    .navigationBarHidden(true)

                case .viewReport:
                    ViewReportFlowCoordinator(
                        coreService: coreService,
                        onBack: { pop() }
                    )
                    .navigationBarHidden(true)
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

    private func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    private func replaceCurrentRoute(with route: HomeAppRoute) {
        guard !path.isEmpty else {
            path = [route]
            return
        }

        var updatedPath = path
        updatedPath.removeLast()
        updatedPath.append(route)
        path = updatedPath
    }

    private func syncTabBarVisibility() {
        tabBarVisibilityStore.isVisible = path.isEmpty
    }
}

private struct ViewReportFlowCoordinator: View {
    let coreService: any HasCoreService
    let onBack: () -> Void
    @State private var showsError = false

    var body: some View {
        ZStack {
            ViewReportFactory.make(
                viewModel: ViewReportViewModel(
                    service: ViewReportService(coreService: coreService)
                ),
                onLoadingFinished: {
                    showsError = true
                }
            )

            if showsError {
                FullScreenErrorView(
                    title: Strings.HomeApp.genericErrorTitle,
                    description: Strings.HomeApp.genericErrorDescription,
                    primaryButtonTitle: Strings.Common.tryAgain,
                    secondaryButtonTitle: Strings.HomeApp.tryLater,
                    onPrimaryAction: {
                        showsError = false
                    },
                    onSecondaryAction: {
                        onBack()
                    }
                )
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
}
