import AetherisDesignSystem
import SwiftUI

struct RegisterInputSkeleton: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                SkeletonView(.rect)
                    .frame(width: 250, height: 30)
                    .cornerRadius(25)
                    .padding(.top, 50)
                
                SkeletonView(.rect)
                    .frame(width: 350, height: 20)
                    .cornerRadius(25)
                
                SkeletonView(.rect)
                    .frame(width: 200, height: 20)
                    .cornerRadius(25)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 25)

            Spacer()
            
            SkeletonView(.rect)
                .frame(width: 350, height: 30)
            
            SkeletonView(.rect)
                .frame(width: 250, height: 50)
                .cornerRadius(25)
                .padding(.vertical, 25)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundColorA)
    }
}

#Preview {
    RegisterInputSkeleton()
}
