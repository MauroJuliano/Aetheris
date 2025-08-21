import SwiftUI

enum SpectrumRatio {
    case horizontal
    case vertical
    
    var size: CGSize {
        switch self {
        case .horizontal:
            return CGSize(width: 140, height: 100)
        case .vertical:
            return CGSize(width: 140, height: 215)
        }
    }
}

struct CardDistribution: View {
    @State var primaryColor: Color
    @State var backgroundColor: Color
    @State var spectrumRatio: SpectrumRatio
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(backgroundColor)
            
            VStack() {
                Spacer()
                
                HStack {
                    Image(systemName: "cube.transparent")
                        .foregroundColor(primaryColor)
                    
                    Spacer()
                }
                
                Spacer()
                Spacer()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Flux Card")
                            .multilineTextAlignment(.leading)
                            .font(.caption)
                            .foregroundStyle(primaryColor)
                        
                        Text("$22.42")
                            .multilineTextAlignment(.leading)
                            .font(.headline)
                            .foregroundStyle(primaryColor)
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding(8)
        }
        .frame(width: spectrumRatio.size.width, height: spectrumRatio.size.height)
        .shadow(color: .black.opacity(0.3),radius: 10, x: 5, y: 0)
    }
}

#Preview {
    CardDistribution(primaryColor: .white, backgroundColor: .primary, spectrumRatio: .vertical)
}
