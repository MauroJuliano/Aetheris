import SwiftUI
import AetherisDesignSystem

struct LoadingScreen: View {
    @State private var progress: Double = 0
    @State private var currentIndex = 0
    @State private var opacity = 1.0
    
    private var messages = ["Loading", "Anytime now", "Wait"]
    private let fadeDuration = 0.5
    
    private var steps: [Double] {
        [0.0, 0.5, 0.9, 1.0]
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(messages[currentIndex])
                        .font(AppTypography.onboardingBody)
                        .fontWeight(.semibold)
                        .opacity(opacity)
                        .animation(.easeInOut(duration: fadeDuration),
                                   value: opacity)
                        
                    ProgressView(value: progress)
                        .progressViewStyle(LinearProgressViewStyle(tint: .black))
                        .frame(width: 150)
                }
                .padding()
                
                Spacer()
            }
            .padding(.bottom, AppSpacing.controlHeight)
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
                if progress < 1 {
                    progress += 0.01
                    
                    for i in 1..<steps.count {
                        if progress >= steps[i - 1] && progress < steps[i] {
                            let targetIndex = i - 1
                            if currentIndex != targetIndex {
                                withAnimation {
                                    opacity = 0.0
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + fadeDuration) {
                                    currentIndex = targetIndex
                                    withAnimation {
                                        opacity = 1.0
                                    }
                                }
                            }
                            break
                        }
                    }
                } else {
                    timer.invalidate()
                }
            }
        }
    }
}

#Preview {
    LoadingScreen()
}
