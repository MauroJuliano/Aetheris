import SwiftUI

enum ResumeFactory {
    static func make(onContinue: @escaping () -> Void) -> ResumeView {
        let viewModel = ResumeViewModel()
        return ResumeView(viewModel: viewModel, onContinue: onContinue)
    }
}
