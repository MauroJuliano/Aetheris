import SwiftUI

extension View {
    func skeletonize(_ isLoading: Bool,
                     placeholder: @escaping () -> some View) -> some View {
        modifier(_Skeletonize(isLoading: isLoading, placeholder: placeholder))
    }
}

private struct _Skeletonize<PH: View>: ViewModifier {
    let isLoading: Bool
    let placeholder: () -> PH
    
    func body(content: Content) -> some View {
        Group {
            if isLoading { placeholder() } else { content }
        }
    }
}
