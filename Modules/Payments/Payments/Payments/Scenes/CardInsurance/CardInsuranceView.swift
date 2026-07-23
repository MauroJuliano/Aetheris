import Core
import AetherisDesignSystem
import SwiftUI

struct CardInsurance: View {
    @StateObject private var viewModel: CardInsuranceViewModel

    init(viewModel: CardInsuranceViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                Image("melissa")
                    .resizable()
                    .frame(height: 500)
                    .scaledToFit()
                    .shadow(color: .gray.opacity(0.2), radius: 16, y: 5)
                    .overlay {
                        VStack {
                            VStack(alignment: .leading, spacing: 12) {
                                if viewModel.isLoading {
                                    ProgressView()
                                        .frame(maxWidth: .infinity)
                                } else {
                                    ForEach(viewModel.bullets) { bullet in
                                        BulletPoint(text: bullet.text)
                                    }
                                }
                            }
                            .padding()
                            .padding(.top, 40)

                            Button {
                            } label: {
                                RoundedRectangle(cornerRadius: AppRadius.large)
                                    .fill(Color.backgroundColorA)
                                    .appShadow(AppShadow.card)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: AppRadius.pill)
                                            .stroke(Color.border, lineWidth: 1)
                                    )
                                    .overlay(
                                        Text(Strings.CardInsurance.continueButton)
                                            .foregroundStyle(Color.accentColorBrown)
                                            .font(AppTypography.button)
                                            .appShadow(AppShadow.control)
                                    )
                                    .frame(width: 300, height: 50)
                            }
                            .padding(.top, 50)

                            Color.clear.frame(height: 50)
                        }
                        .padding()
                        .background(
                            RoundedCorner(radius: 50, corners: [.topLeft, .topRight])
                                .fill(Color.white)
                        )
                        .offset(y: 350)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
        }
        .appScreenBackground()
        .task { await viewModel.load() }
    }
}

private struct BulletPoint: View {
    let text: String

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Image(systemName: "circle.fill")
                .font(.system(size: 6))
                .padding(.top, 4)

            Text(text)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

private struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

