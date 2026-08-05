import Testing
@testable import AetherisHome

@Suite("HomeNavigationState")
struct HomeNavigationStateTests {
    @Test
    func initialState_isAtRoot() {
        let sut = HomeNavigationState()

        #expect(sut.isAtRoot)
        #expect(sut.path.isEmpty)
    }

    @Test
    func push_appendsEveryRoute() {
        var sut = HomeNavigationState()

        sut.push(.card)
        sut.push(.notifications)
        sut.push(.allServices)

        #expect(sut.path.count == 3)
        #expect(!sut.isAtRoot)
    }

    @Test
    func pop_removesOnlyLastRouteAndIsSafeAtRoot() {
        var sut = HomeNavigationState()
        sut.pop()
        #expect(sut.isAtRoot)

        sut.push(.card)
        sut.push(.notifications)
        sut.pop()

        #expect(sut.path.count == 1)
    }

    @Test
    func replaceCurrent_preservesPathDepth() {
        var sut = HomeNavigationState()
        sut.push(.card)
        sut.push(.beneficiaryList)

        sut.replaceCurrent(with: .viewReport)

        #expect(sut.path.count == 2)
    }

    @Test
    func replaceCurrent_pushesRouteWhenAtRoot() {
        var sut = HomeNavigationState()

        sut.replaceCurrent(with: .viewReport)

        #expect(sut.path.count == 1)
    }

    @Test
    func beneficiaryRoutes_preserveNavigationDepthWhenReplacing() {
        var sut = HomeNavigationState()

        sut.push(.allServices)
        sut.push(.beneficiaryList)
        sut.replaceCurrent(with: .addBeneficiary)

        #expect(sut.path.count == 2)
    }

    @Test
    func reset_returnsToRootFromDeepLink() {
        var sut = HomeNavigationState()
        sut.push(.card)
        sut.push(.viewReport)

        sut.reset()

        #expect(sut.isAtRoot)
    }
}
