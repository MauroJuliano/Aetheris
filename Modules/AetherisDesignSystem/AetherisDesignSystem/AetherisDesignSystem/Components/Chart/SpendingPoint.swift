import Foundation

struct SpendingPoint: Identifiable, Equatable {
    let id = UUID()
    let day: String
    let amount: Double
}
