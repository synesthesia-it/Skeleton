import UIKit

enum FontType {
    //customize fonts, these won't work out of the box
    case roboto
    case lato
    
    fileprivate func font(weight: UIFont.Weight, size: CGFloat) -> UIFont {
        let fontName: String
        switch self {
        case .roboto :
            switch weight {
            case .regular: fontName = "Roboto"
            case .bold: fontName = "Roboto"
            default: fontName = "Roboto"
            }
        case .lato :
            switch weight {
            case .light: fontName = "Lato"
            case .regular: fontName = "Lato"
            default:  fontName = "Lato"
            }
        }
        return UIFont(name: fontName, size: size) ?? .systemFont(ofSize: size)
    }
}

extension UIFont {
    static func type(type: FontType, weight: UIFont.Weight, size: CGFloat) -> UIFont {
        return type.font(weight: weight, size: size)
    }
}
