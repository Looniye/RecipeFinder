import UIKit

final class TabBarController: UITabBarController {
	override func viewDidLoad() {
		super.viewDidLoad()
		configureTabBarAppearance()
		tabBar.updateShadowColor(for: tabBar)
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		tabBar.updateShadowColor(for: tabBar)
	}
}

private extension TabBarController {
	func configureTabBarAppearance() {
		tabBar.backgroundColor = ColorStyle.systemBackground.color
		tabBar.layer.cornerRadius = AppConstants.Layer.cornerRadius
		tabBar.layer.shadowOffset = AppConstants.ShadowConstant.offset
		tabBar.layer.shadowRadius = AppConstants.ShadowConstant.radius
		tabBar.layer.shadowOpacity = AppConstants.ShadowConstant.opacity
		tabBar.tintColor = ColorStyle.orange.color
	}
}
