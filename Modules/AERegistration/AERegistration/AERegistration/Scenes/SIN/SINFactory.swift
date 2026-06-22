import SwiftUI

enum SINFactory {
    @MainActor static func make(onContinue: @escaping () -> Void) -> some View {
        let service: SINServiceProtocol = MockSINService()
        let viewModel = SINViewModel(service: service)
        return SINView(viewModel: viewModel, onContinue: onContinue)
    }
}
