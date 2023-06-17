import UIKit

protocol FavoriteRecipesRouterProtocol {
	func initialViewController()
	func showDetailRecipeViewController(recipe: Recipe?)
}

final class FavoriteRecipesRouter: FavoriteRecipesRouterProtocol {
	weak var tabBarController: TabBarController?
	var screenAssembler: ScreenAssemblerProtocol?
	
	init(tabBarController: TabBarController, screenAssembler: ScreenAssemblerProtocol) {
		self.tabBarController = tabBarController
		self.screenAssembler = screenAssembler
	}
	
	func initialViewController() {
		guard let tabBarController = tabBarController else {
			return
		}
		guard let favoriteViewController = screenAssembler?.createFavoriteRecipesModule(router: self) else { return }
		
		favoriteViewController.tabBarItem = UITabBarItem(
			title: AppConstants.TabBarTitle.favorites,
			image: AppConstants.TabBarImage.favorites,
			selectedImage: nil
		)
		
		let navigationController = NavigationViewController(rootViewController: favoriteViewController)
		navigationController.tabBarItem = favoriteViewController.tabBarItem
		
		tabBarController.viewControllers?.append(navigationController)
	}
	func showDetailRecipeViewController(recipe: Recipe?) {
		if let tabBarController = tabBarController,
		   let navigationController = tabBarController.selectedViewController as? UINavigationController {
			guard let detailRecipeViewController = screenAssembler?.createDetailRecipeModule(recipe: recipe) else { return }
			navigationController.pushViewController(detailRecipeViewController, animated: true)
		}
	}
}
