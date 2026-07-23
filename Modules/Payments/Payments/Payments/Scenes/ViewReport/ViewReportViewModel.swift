import Foundation
import SwiftUI

@MainActor
final class ViewReportViewModel: ObservableObject {
    @Published private(set) var isLoading = false

    private let service: any ViewReportServicing

    init(service: any ViewReportServicing) {
        self.service = service
    }

    func load(onLoadingFinished: @escaping () -> Void) {
        guard !isLoading else { return }
        isLoading = true

        Task {
            _ = try? await service.loadReport()
            try? await Task.sleep(nanoseconds: 1_500_000_000)
            await MainActor.run {
                onLoadingFinished()
                isLoading = false
            }
        }
    }
}
