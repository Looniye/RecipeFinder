import UIKit

final class NavigationViewController: UINavigationController {
	override func viewDidLoad() {
		super.viewDidLoad()
		configureNavigationControllerAppearance()
	}
}

private extension NavigationViewController {
	func configureNavigationControllerAppearance() {
		navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
		
		if #available(iOS 13.0, *) {
			navigationBar.tintColor = UIColor { (traitCollection) -> UIColor in
				return traitCollection.userInterfaceStyle == .dark ? UIColor.white : UIColor.black
			}
		} else {
			navigationBar.tintColor = UIColor.black
		}
	}
}
