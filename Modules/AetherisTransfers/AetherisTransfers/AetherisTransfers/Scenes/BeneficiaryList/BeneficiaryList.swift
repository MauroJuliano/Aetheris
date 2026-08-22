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
            if let errorMessage = viewModel.errorMessage {
                errorView(message: errorMessage)
            } else if !viewModel.isLoading, viewModel.beneficiaries.isEmpty {
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
                    BeneficiarySearchBar(
                        text: $searchText,
                        placeholder: Strings.BeneficiaryList.searchPlaceholder,
                        clearLabel: Strings.BeneficiaryList.clearSearch
                    )
                    .toSkeleton(enable: viewModel.isLoading)
                        .padding(.top, AppSpacing.medium)

                    if searchQuery.isEmpty {
                        if viewModel.isLoading {
                            recentSectionSkeleton
                        } else {
                            recentSection
                        }
                    }

                    if viewModel.isLoading {
                        allBeneficiariesSkeleton
                    } else if filteredAllBeneficiaries.isEmpty {
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
        viewModel.recentBeneficiaries
    }

    private var filteredAllBeneficiaries: [Beneficiary] {
        viewModel.filteredBeneficiaries(query: searchQuery)
    }

    private var beneficiarySections: [BeneficiaryListViewModel.Section] {
        viewModel.sections(query: searchQuery)
    }

    private var recentSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text(Strings.BeneficiaryList.recent)
                .font(AppTypography.body)
                .bold()
                .foregroundStyle(Color.textPrimary)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: AppSpacing.medium) {
                    ForEach(recentBeneficiaries) { beneficiary in
                        RecentContactItem(
                            model: beneficiary.recentItemModel,
                            onTap: {
                                onSelect(beneficiary)
                            }
                        )
                        .toSkeleton(enable: viewModel.isLoading)
                    }
                }
            }
        }
    }

    private var recentSectionSkeleton: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            SkeletonBlock(width: 74, height: 18, radius: 8)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppSpacing.medium) {
                    ForEach(0..<4, id: \.self) { _ in
                        RecentContactItem(
                            model: .init(
                                id: UUID(),
                                name: "Placeholder",
                                imageName: nil
                            ),
                            onTap: {}
                        )
                        .toSkeleton(enable: true)
                    }
                }
            }
        }
    }

    private var allBeneficiariesSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text(searchQuery.isEmpty ? Strings.BeneficiaryList.savedBeneficiaries : "Results")
                .font(AppTypography.body)
                .bold()
                .foregroundStyle(Color.textPrimary)

            LazyVStack(spacing: AppSpacing.large) {
                ForEach(beneficiarySections, id: \.letter) { section in
                    BeneficiaryAlphabetSection(
                        letter: section.letter,
                        beneficiaries: section.beneficiaries,
                        isLoading: viewModel.isLoading,
                        onSelect: onSelect
                    )
                }
            }
        }
    }

    private var allBeneficiariesSkeleton: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            SkeletonBlock(width: 150, height: 18, radius: 8)

            VStack(spacing: AppSpacing.large) {
                ForEach(beneficiarySections, id: \.letter) { section in
                    VStack(alignment: .leading, spacing: AppSpacing.small) {
                        SkeletonBlock(width: 14, height: 14, radius: 7)

                        VStack(spacing: AppSpacing.medium) {
                            ForEach(section.beneficiaries) { beneficiary in
                                ContactCardRow(
                                    model: beneficiary.cardRowModel,
                                    onTap: {}
                                )
                                .toSkeleton(enable: true)
                            }
                        }
                    }
                }
            }
        }
    }

    private var searchEmptyState: some View {
        AppEmptyStateView(
            title: Strings.BeneficiaryList.noSearchResults,
            description: Strings.BeneficiaryList.tryAnotherSearch
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

extension Beneficiary {
    var cardRowModel: ContactCardRowModel {
        .init(
            id: id,
            name: name,
            contactInformation: pixKey,
            imageName: image
        )
    }

    var recentItemModel: RecentContactItemModel {
        .init(
            id: id,
            name: name,
            imageName: image
        )
    }

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
