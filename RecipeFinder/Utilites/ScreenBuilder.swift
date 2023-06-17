import UIKit

protocol ScreenAssemblerProtocol {
	func createSearchRecipesModule(router: SearchRecipesRouterProtocol) -> UIViewController
	func createFavoriteRecipesModule(router: FavoriteRecipesRouterProtocol) -> UIViewController
	func createDetailRecipeModule(recipe: Recipe?) -> UIViewController
}

final class ScreenAssembler: ScreenAssemblerProtocol {
	func createSearchRecipesModule(router: SearchRecipesRouterProtocol) -> UIViewController {
		let searchRecipesPresenter = SearchRecipesPresenter(router: router)
		let view = SearchRecipesViewController(with: searchRecipesPresenter)
		view.searchRecipesPresenter = searchRecipesPresenter
		return view
	}
	
	func createFavoriteRecipesModule(router: FavoriteRecipesRouterProtocol) -> UIViewController {
		let favoriteRecipesPresenter = FavoriteRecipesPresenter(router: router)
		let view = FavoriteRecipesViewController(with: favoriteRecipesPresenter)
		view.favoriteRecipesPresenter = favoriteRecipesPresenter
		return view
	}
	
	func createDetailRecipeModule(recipe: Recipe?) -> UIViewController {
		let detailRecipePresenter = DetailRecipePresenter(recipe: recipe)
		let view = DetailRecipeViewController(with: detailRecipePresenter)
		view.detailRecipePresenter = detailRecipePresenter
		return view
	}
}
