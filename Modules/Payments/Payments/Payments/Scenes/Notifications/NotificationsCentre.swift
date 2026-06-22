import AetherisDesignSystem
import SwiftUI

struct NotificationsCentre: View {
    @Binding var isPresented: Bool
    @StateObject private var viewModel = NotificationsCentreViewModel()

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {

                NavBar(
                    hasNotifications: false,
                    hasBackButton: true,
                    model: .init(
                        firstText: "Notifications Centre",
                        hasInitialSpace: false
                    ),
                    onBack: { isPresented = false }
                )

                ForEach(viewModel.sections) { section in
                    VStack(alignment: .leading, spacing: 12) {

                        Text(section.title)
                            .foregroundStyle(.black)
                            .font(AppFont.roboto(.bold, size: 24))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)

                        VStack {
                            ForEach(section.items) { cell in
                                NotificationCell(model: cell)
                                    .padding(.horizontal)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.backgroundColorA)
                                .shadow(color: .gray.opacity(0.25), radius: 16, y: 5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(.gray.opacity(0.25), lineWidth: 1)
                                )
                        )
                    }
                }
            }
        }
        .padding(.horizontal)
        .background(Color.backgroundColorA)
        .task {
            await viewModel.load()
        }
    }
}

#Preview {
    NotificationsCentre(isPresented: .constant(false))
}
