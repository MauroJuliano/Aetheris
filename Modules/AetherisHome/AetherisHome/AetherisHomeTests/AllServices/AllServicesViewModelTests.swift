import Testing
@testable import AetherisHome

@MainActor
@Suite("AllServicesViewModel")
struct AllServicesViewModelTests {
    @Test
    func initialState_isLoadingAndEmpty() {
        let sut = AllServicesViewModel(service: AllServicesServiceSpy(items: []))

        #expect(sut.isLoading)
        #expect(sut.items.isEmpty)
        #expect(sut.displayedItems.count == 6)
        #expect(sut.errorMessage == nil)
    }

    @Test
    func load_mapsItemsAndFinishesLoading() async {
        let items = [AllServicesFixtures.items[0], AllServicesFixtures.items[1]]
        let service = AllServicesServiceSpy(items: items)
        let sut = AllServicesViewModel(service: service)

        await sut.load()

        #expect(!sut.isLoading)
        #expect(sut.items.map(\.title) == items.map(\.title))
        #expect(sut.displayedItems.map(\.title) == items.map(\.title))
        #expect(sut.errorMessage == nil)
        #expect(service.loadCalls == 1)
    }
}

private final class AllServicesServiceSpy: AllServicesServicing {
    let items: [AllServicesItem]
    private(set) var loadCalls = 0

    init(items: [AllServicesItem]) { self.items = items }

    func loadServices() async throws -> [AllServicesItem] {
        loadCalls += 1
        return items
    }
}
