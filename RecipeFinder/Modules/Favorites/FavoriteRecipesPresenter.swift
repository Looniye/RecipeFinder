protocol IFavoriteRecipesPresenter {
	func viewDidLoad(ui: IFavoriteRecipesView)
	func viewWillAppear(ui: IFavoriteRecipesView)
}

final class FavoriteRecipesPresenter {
	private var router: FavoriteRecipesRouterProtocol?
	private var searchRecipesPresenter: SearchRecipesPresenterProtocol?
	var ui: IFavoriteRecipesView?
	
	init(router: FavoriteRecipesRouterProtocol) {
		self.router = router
	}
	
	func tapOnTheCell(recipe: Recipe?) {
		router?.showDetailRecipeViewController(recipe: recipe)
	}
}

extension FavoriteRecipesPresenter: IFavoriteRecipesPresenter{
	func viewDidLoad(ui: IFavoriteRecipesView) {
		self.ui = ui
		self.ui?.setDelegateDataSource(delegate: ui)
		let favoriteRecipe = RecipeDataManager.shared.loadRecipes()
		self.ui?.updateUI(with: favoriteRecipe)
	}
	
	func viewWillAppear(ui: IFavoriteRecipesView) {
		let favoriteRecipe = RecipeDataManager.shared.loadRecipes()
		self.ui?.updateUI(with: favoriteRecipe)
	}
}
