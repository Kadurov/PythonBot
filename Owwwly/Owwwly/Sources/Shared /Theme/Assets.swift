import UIKit

enum Assets: String {
    case logoIcon
    
    private var name: String {
        switch self {
            
        case .logoIcon: return "logo_icon"
        }
    }
}

extension Assets {
    
    public var image: UIImage {
        return UIImage(imageLiteralResourceName: self.name)
    }
}

