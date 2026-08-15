import AetherisDesignSystem
import Core
import SwiftUI

struct BeneficiaryList: View {
    @StateObject private var viewModel: BeneficiaryListViewModel
    @State private var searchText = ""

    let onSelect: (Beneficiary) -> Void
    let onBack: () -> Void

    init(
        viewModel: BeneficiaryListViewModel,
        onSelect: @escaping (Beneficiary) -> Void,
        onBack: @escaping () -> Void
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onSelect = onSelect
        self.onBack = onBack
    }

    var body: some View {
        ZStack {
            if viewModel.isLoading {
                BeneficiaryListSkeleton()
            } else if let errorMessage = viewModel.errorMessage {
                errorView(message: errorMessage)
            } else if viewModel.beneficiaries.isEmpty {
                emptyState
            } else {
                loadedContent
            }
        }
        .padding(.horizontal, AppSpacing.screenHorizontal)
        .appScreenBackground()
        .task { await viewModel.load() }
    }

    var loadedContent: some View {
        VStack {
            NavBar(
                hasBackButton: true,
                model: .init(
                    firstText: Strings.BeneficiaryList.title,
                    hasInitialSpace: false
                ),
                onBack: onBack
            )

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: AppSpacing.medium) {
                    BeneficiarySearchBar(
                        text: $searchText
                    )
                    .padding(.top, AppSpacing.medium)

                    Text(Strings.BeneficiaryList.savedBeneficiaries)
                        .font(AppTypography.body)
                        .bold()
                        .foregroundStyle(Color.textPrimary)

                    LazyVStack(spacing: AppSpacing.medium) {
                        ForEach(Array(filteredBeneficiaries.enumerated()), id: \.element.id) { index, cell in
                            BeneficiaryCell(
                                model: cell,
                                isRecent: index == 0,
                                onChange: { selected in
                                    onSelect(selected)
                                }
                            )
                        }
                    }
                }
                .padding(.bottom, AppSpacing.bottomBarClearance)
            }
            .appScreenBackground()
        }
    }

    private var filteredBeneficiaries: [Beneficiary] {
        let query = searchText.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !query.isEmpty else {
            return viewModel.beneficiaries
        }

        return viewModel.beneficiaries.filter {
            $0.name.matchesSearch(query) ||
                $0.pixKey.matchesSearch(query)
        }
    }

    func errorView(message: String) -> some View {
        FeedbackView(
            title: Strings.BeneficiaryList.unavailableTitle,
            description: message,
            primaryButtonTitle: Strings.Common.tryAgain,
            secondaryButtonTitle: Strings.Common.back,
            onPrimaryAction: {
                Task { await viewModel.load() }
            },
            onSecondaryAction: onBack
        )
    }

    var emptyState: some View {
        AppEmptyStateView(
            title: Strings.BeneficiaryList.emptyTitle,
            description: Strings.BeneficiaryList.emptyDescription
        )
    }
}

private extension String {
    func matchesSearch(_ query: String) -> Bool {
        let normalizedValue = folding(
            options: [.diacriticInsensitive, .caseInsensitive],
            locale: .current
        )

        let normalizedQuery = query.folding(
            options: [.diacriticInsensitive, .caseInsensitive],
            locale: .current
        )

        return normalizedValue.contains(normalizedQuery)
    }
}

#Preview {
    BeneficiaryList(
        viewModel: BeneficiaryListViewModel(
            service: BeneficiaryListService(
                coreService: DemoCoreService(delay: 0)
            )
        ),
        onSelect: { _ in },
        onBack: {}
    )
}
