import SwiftUI

public enum AppFont {
    public static func montserrat(_ weight: MontserratWeight, size: CGFloat) -> Font {
        .custom(weight.rawValue, size: size)
    }

    public static func roboto(_ weight: RobotWeight, size: CGFloat) -> Font {
        .custom(weight.rawValue, size: size)
    }
    
    public enum MontserratWeight: String {
        case regular = "Montserrat-Regular"
        case medium = "Montserrat-Medium"
        case semibold = "Montserrat-SemiBold"
        case bold = "Montserrat-Bold"
    }
    
    public enum RobotWeight: String {
        case regular = "RobotoMono-Regular"
        case medium = "RobotoMono-Medium"
        case semibold = "RobotoMono-SemiBold"
        case bold = "RobotoMono-Bold"
    }
}
