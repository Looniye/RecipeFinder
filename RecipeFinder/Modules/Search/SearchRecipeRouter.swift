import UIKit

protocol SearchRecipesRouterProtocol {
	func initialViewController()
	func showDetailRecipeViewController(recipe: Recipe?)
}

final class SearchRecipesRouter: SearchRecipesRouterProtocol {
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
		guard let searchViewController = screenAssembler?.createSearchRecipesModule(router: self) else { return }

		searchViewController.tabBarItem = UITabBarItem(
			title: AppConstants.TabBarTitle.home,
			image: AppConstants.TabBarImage.home,
			selectedImage: nil
		)
		
		let navigationController = NavigationViewController(rootViewController: searchViewController)
		tabBarController.viewControllers = [navigationController]
	}

	func showDetailRecipeViewController(recipe: Recipe?) {
		if let tabBarController = tabBarController,
		   let navigationController = tabBarController.selectedViewController as? UINavigationController {
			guard let detailRecipeViewController = screenAssembler?.createDetailRecipeModule(recipe: recipe) else { return }
			navigationController.pushViewController(detailRecipeViewController, animated: true)
		}
	}
}
