import UIKit

enum Theme { }

extension Theme {
    enum Colors {
        static let white: UIColor = .white
        static let dark: UIColor = .init(hex: "#1B1D1F") ?? .darkGray

        static let mainBackgroundColor: UIColor = white
        
        static let statusBarStyleOnMain: UIStatusBarStyle = .lightContent
    }
}

private extension UIFont.Weight {
    var sfFontName: String? {
        switch self {
        case .regular:
            return "SF-Regular"
        case .medium:
            return "SF-Medium"
        case .bold:
            return "SF-Bold"
        default:
            return nil
        }
    }

    var monthoersFontName: String? {
        switch self {
        case .regular:
            return "Monthoers"
        default:
            return nil
        }
    }
}

extension Theme {
    enum Fonts {

        private static func font(for weight: UIFont.Weight, size: CGFloat = 17.0) -> UIFont {
            guard let name = weight.sfFontName,
                let font = UIFont(name: name, size: size)
                else {
                    return UIFont.systemFont(ofSize: size, weight: weight)
            }
            return font
        }

        static let regularFont: UIFont = font(for: .regular)
        static let medium: UIFont = font(for: .medium)
        static let bold: UIFont = font(for: .bold)
    }

    enum LogoFonts {

        private static func font(for weight: UIFont.Weight, size: CGFloat = 35.0) -> UIFont {
            guard let name = weight.monthoersFontName,
                  let font = UIFont(name: name, size: size)
                else {
                    return UIFont.systemFont(ofSize: size, weight: weight)
            }
            return font
        }

        static let regularFont: UIFont = font(for: .regular)
    }
}
