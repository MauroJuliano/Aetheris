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

    private var loadedContent: some View {
        VStack(spacing: 0) {
            NavBar(
                hasBackButton: true,
                model: .init(
                    firstText: Strings.BeneficiaryList.title,
                    hasInitialSpace: false
                ),
                onBack: onBack
            )

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: AppSpacing.large) {
                    BeneficiarySearchBar(text: $searchText)
                        .padding(.top, AppSpacing.medium)

                    if searchQuery.isEmpty {
                        recentSection
                    }

                    if filteredAllBeneficiaries.isEmpty {
                        searchEmptyState
                    } else {
                        allBeneficiariesSection
                    }
                }
                .padding(.bottom, AppSpacing.bottomBarClearance)
            }
            .appScreenBackground()
        }
    }

    private var searchQuery: String {
        searchText.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var recentBeneficiaries: [Beneficiary] {
        Array(viewModel.beneficiaries.prefix(4))
    }

    private var allBeneficiaries: [Beneficiary] {
        BeneficiaryFixtures.defaults
    }

    private var filteredAllBeneficiaries: [Beneficiary] {
        guard !searchQuery.isEmpty else {
            return allBeneficiaries
        }

        return allBeneficiaries.filter {
            $0.name.matchesSearch(searchQuery) ||
                $0.pixKey.matchesSearch(searchQuery)
        }
    }

    private var beneficiarySections: [(letter: String, beneficiaries: [Beneficiary])] {
        let sorted = filteredAllBeneficiaries.sorted {
            $0.name.localizedStandardCompare($1.name) == .orderedAscending
        }

        let grouped = Dictionary(grouping: sorted) { beneficiary in
            beneficiary.sectionKey
        }

        return grouped.keys.sorted().map { letter in
            (
                letter: letter,
                beneficiaries: grouped[letter] ?? []
            )
        }
    }

    private var recentSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text("Recent")
                .font(AppTypography.body)
                .bold()
                .foregroundStyle(Color.textPrimary)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: AppSpacing.medium) {
                    ForEach(recentBeneficiaries) { beneficiary in
                        RecentBeneficiaryCell(
                            model: beneficiary,
                            onSelect: {
                                onSelect(beneficiary)
                            }
                        )
                    }
                }
            }
        }
    }

    private var allBeneficiariesSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text(searchQuery.isEmpty ? "All beneficiaries" : "Results")
                .font(AppTypography.body)
                .bold()
                .foregroundStyle(Color.textPrimary)

            LazyVStack(spacing: AppSpacing.large) {
                ForEach(beneficiarySections, id: \.letter) { section in
                    BeneficiaryAlphabetSection(
                        letter: section.letter,
                        beneficiaries: section.beneficiaries,
                        onSelect: onSelect
                    )
                }
            }
        }
    }

    private var searchEmptyState: some View {
        AppEmptyStateView(
            title: "No results",
            description: "Try another name or PIX key."
        )
    }

    private func errorView(message: String) -> some View {
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

    private var emptyState: some View {
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

private extension Beneficiary {
    var sectionKey: String {
        let normalized = name.folding(
            options: [.diacriticInsensitive, .caseInsensitive],
            locale: .current
        )

        return String(normalized.prefix(1)).uppercased()
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
