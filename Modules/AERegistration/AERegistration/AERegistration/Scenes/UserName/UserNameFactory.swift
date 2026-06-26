import SwiftUI

enum UserNameFactory {
    static func make(onContinue: @escaping () -> Void) -> some View {
        let service = mockUserNameService()
        let viewModel = UserNameViewModel(service: service)
        return UserNameView(viewModel: viewModel, onContinue: onContinue)
    }
}
