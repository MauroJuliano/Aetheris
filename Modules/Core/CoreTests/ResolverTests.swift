import Testing
@testable import Core

@Suite("Resolver")
struct ResolverTests {
    @Test
    func registerAndResolve_returnsFactoryResultEachTime_andCanReplaceFactory() {
        let resolver = Resolver.shared
        let type = UniqueService.self
        var factoryCalls = 0

        resolver.register(type) {
            factoryCalls += 1
            return UniqueService(value: factoryCalls)
        }

        let first: UniqueService = resolver.resolve()
        let second: UniqueService = resolver.resolve()

        #expect(first.value == 1)
        #expect(second.value == 2)

        resolver.register(ReplaceableService.self) {
            ReplaceableService(label: "first")
        }
        resolver.register(ReplaceableService.self) {
            ReplaceableService(label: "second")
        }

        let resolved: ReplaceableService = resolver.resolve()

        #expect(resolved.label == "second")
    }
}

private struct UniqueService: Equatable {
    let value: Int
}

private struct ReplaceableService: Equatable {
    let label: String
}
