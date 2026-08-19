import SwiftUI

struct MinimalDropdownSkeleton: View {
    var body: some View {
        HStack {
            SkeletonBlock(width: 120, height: 18, radius: 9)
            Spacer()
            SkeletonBlock(width: 92, height: 18, radius: 9)
        }
        .padding()
    }
}

#Preview {
    MinimalDropdownSkeleton()
        .padding()
        .appScreenBackground()
}
