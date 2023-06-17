import UIKit

extension UIView {
	func updateShadowColor(for view: UIView) {
		if #available(iOS 13.0, *) {
			let invertedSystemBackground = UIColor { (traitCollection) -> UIColor in
				return traitCollection.userInterfaceStyle == .dark ? UIColor.white : UIColor.black
			}
			view.layer.shadowColor = invertedSystemBackground.cgColor
		} else {
			view.layer.shadowColor = UIColor.black.cgColor
		}
	}
	
	func updateTintColor(for view: UIView) {
		if #available(iOS 13.0, *) {
			let invertedSystemBackground = UIColor { (traitCollection) -> UIColor in
				return traitCollection.userInterfaceStyle == .dark ? UIColor.white : UIColor.black
			}
			view.tintColor = invertedSystemBackground
		} else {
			view.tintColor = UIColor.black
		}
	}
}
