import SwiftUI

enum MothersNameInputFactory {
    static func make(onContinue: @escaping () -> Void) -> MothersNameInputView {
        let viewModel = MothersNameInputViewModel()
        return MothersNameInputView(viewModel: viewModel, onContinue: onContinue)
    }
}
