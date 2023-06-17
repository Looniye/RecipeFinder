import UIKit

enum ColorStyle {
	case red
	case orange
	case blue
	case systemBackground
	case grayAlpha
	case translucent
	case white
	
	var color: UIColor {
		switch self {
		case .red:
			return UIColor.systemRed
		case .orange:
			return UIColor.systemOrange
		case .blue:
			return UIColor(red: 0.2, green: 0.6, blue: 0.4, alpha: 1.0)
		case .systemBackground:
			return UIColor.systemBackground
		case .grayAlpha:
			return UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
		case .translucent:
			return UIColor.systemGray.withAlphaComponent(0.5)
		case .white:
			return UIColor.white
		}
	}
}
