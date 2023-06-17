import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?
	var searchRecipesRouter: SearchRecipesRouterProtocol?
	var favoriteRecipesRouter: FavoriteRecipesRouterProtocol?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		let window = UIWindow(windowScene: windowScene)
		self.window = window
		
		let isGetStartedShown = UserDefaults.standard.bool(forKey: AppConstants.isGetStartedShownKey)
		
		if isGetStartedShown {
			showTabBarController()
		} else {
			let getStartedViewController = GetStartedViewController()
			getStartedViewController.delegate = self
			
			window.rootViewController = getStartedViewController
			window.makeKeyAndVisible()
		}
	}
}

extension SceneDelegate {
	func showTabBarController() {
		let tabBarController = TabBarController()
		let screenAssembler = ScreenAssembler()
		searchRecipesRouter = SearchRecipesRouter(tabBarController: tabBarController, screenAssembler: screenAssembler)
		favoriteRecipesRouter = FavoriteRecipesRouter(tabBarController: tabBarController, screenAssembler: screenAssembler)
		
		searchRecipesRouter?.initialViewController()
		favoriteRecipesRouter?.initialViewController()
		
		window?.rootViewController = tabBarController
		window?.makeKeyAndVisible()
	}
}
