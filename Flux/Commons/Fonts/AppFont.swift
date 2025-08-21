import SwiftUI

enum AppFont {
    static func montserrat(_ weight: MontserratWeight, size: CGFloat) -> Font {
        .custom(weight.rawValue, size: size)
    }

    static func roboto(_ weight: RobotWeight, size: CGFloat) -> Font {
        .custom(weight.rawValue, size: size)
    }
    
    enum MontserratWeight: String {
        case regular = "Montserrat-Regular"
        case medium = "Montserrat-Medium"
        case semibold = "Montserrat-SemiBold"
        case bold = "Montserrat-Bold"
    }
    
    enum RobotWeight: String {
        case regular = "RobotoMono-Regular"
        case medium = "RobotoMono-Medium"
        case semibold = "RobotoMono-SemiBold"
        case bold = "RobotoMono-Bold"
    }
}
