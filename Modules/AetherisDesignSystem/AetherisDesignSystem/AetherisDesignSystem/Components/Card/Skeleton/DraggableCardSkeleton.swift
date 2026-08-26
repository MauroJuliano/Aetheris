import SwiftUI

struct DraggableCardSkeleton: View {
    var body: some View {
        CardViewSkeleton()
            .frame(width: 350, height: 200)
    }
}

#Preview {
    DraggableCardSkeleton()
        .padding()
        .appScreenBackground()
}
