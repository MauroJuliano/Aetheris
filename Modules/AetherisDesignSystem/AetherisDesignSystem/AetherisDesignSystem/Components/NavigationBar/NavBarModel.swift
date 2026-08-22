public struct NavBarModel {
    var firstText: String?
    var secondText: String?
    var hasInitialSpace: Bool

    public init(firstText: String? = nil, secondText: String? = nil, hasInitialSpace: Bool) {
        self.firstText = firstText
        self.secondText = secondText
        self.hasInitialSpace = hasInitialSpace
    }
}
