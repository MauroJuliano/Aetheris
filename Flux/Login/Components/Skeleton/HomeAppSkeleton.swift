import SwiftUI

struct HomeAppSkeleton: View {
    var body: some View {
        VStack {
            HStack {
                SkeletonView(.rect)
                    .frame(width: 200, height: 30)
                    .cornerRadius(25, corners: .allCorners)
                
                Spacer()
                
                SkeletonView(.rect)
                    .frame(width: 30, height: 30)
            }
            .padding()
            
            Divider()
            
            
            VStack(alignment: .leading) {
                SkeletonView(.rect)
                    .frame(width: 200, height: 20)
                    .cornerRadius(25, corners: .allCorners)
                    .padding()
                
                SkeletonView(.rect)
                    .frame(width: 350, height: 200)
                    .cornerRadius(25, corners: .allCorners)
                    .padding(.horizontal)
                
                Divider()
                
                SkeletonView(.rect)
                    .frame(width: 200, height: 20)
                    .cornerRadius(25, corners: .allCorners)
                    .padding()
                
                HStack {
                    SkeletonView(.rect)
                        .frame(width: 50, height: 50)
                        .cornerRadius(25, corners: .allCorners)
                    
                    SkeletonView(.rect)
                        .frame(width: 50, height: 50)
                        .cornerRadius(25, corners: .allCorners)
                    
                    SkeletonView(.rect)
                        .frame(width: 50, height: 50)
                        .cornerRadius(25, corners: .allCorners)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                Divider()
                    .padding(.vertical)
                
                HStack(spacing: 35) {
                    SkeletonView(.rect)
                        .frame(width: 160, height: 240)
                        .cornerRadius(25, corners: .allCorners)
                    
                    VStack {
                        SkeletonView(.rect)
                            .frame(width: 160, height: 116)
                            .cornerRadius(25, corners: .allCorners)
                        
                        SkeletonView(.rect)
                            .frame(width: 160, height: 116)
                            .cornerRadius(25, corners: .allCorners)
                    }
                }
                .padding(.horizontal)
            }
            
            
            Spacer()
        }
        .padding(.horizontal)
        .background(Color.backgroundColorA)
    }
}

#Preview {
    HomeAppSkeleton()
}
