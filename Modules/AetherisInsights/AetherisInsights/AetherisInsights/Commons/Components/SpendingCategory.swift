import SwiftUI
import AetherisDesignSystem

struct SpendingCategory: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let amount: String
    let percentage: String
    let icon: String
    let color: Color
}
