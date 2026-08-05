import Foundation
import SwiftUI

@MainActor
final class ViewReportViewModel: ObservableObject {
    @Published private(set) var isLoading = false

    private let service: any ViewReportServicing
    private let loadingDelayNanoseconds: UInt64

    init(
        service: any ViewReportServicing,
        loadingDelayNanoseconds: UInt64 = 1_500_000_000
    ) {
        self.service = service
        self.loadingDelayNanoseconds = loadingDelayNanoseconds
    }

    func load(onLoadingFinished: @escaping () -> Void) {
        guard !isLoading else { return }
        isLoading = true

        Task {
            _ = try? await service.loadReport()
            try? await Task.sleep(nanoseconds: loadingDelayNanoseconds)
            await MainActor.run {
                onLoadingFinished()
                isLoading = false
            }
        }
    }
}
