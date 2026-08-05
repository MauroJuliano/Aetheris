struct CardOptions: Identifiable, Codable, Hashable {
    let id: String
    let label: String
    let icon: String

    init(id: String? = nil, label: String, icon: String) {
        self.id = id ?? label
        self.label = label
        self.icon = icon
    }
}
