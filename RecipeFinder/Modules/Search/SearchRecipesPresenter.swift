import UIKit

protocol ISearchRecipesPresenter {
	func viewDidLoad(ui: ISearchRecipesView)
}

protocol SearchRecipesPresenterProtocol: AnyObject {
	func saveRecipeToDatabase(recipe: Recipe)
}

final class SearchRecipesPresenter: SearchRecipesPresenterProtocol {
	private var recipeByIngredientsService = RecipeByIngredientsService.shared
	private var router: SearchRecipesRouterProtocol?
	private var model: [Recipe]?
	var ui: ISearchRecipesView?
	
	init(router: SearchRecipesRouterProtocol) {
		self.router = router
	}
	
	func getRecipes(with ingredients: [String], completion: @escaping (Error?) -> Void) {
		ui?.activityIndicator.startAnimating()
		
		recipeByIngredientsService.fetchRecipeByIngredients(ingredients: ingredients) { [weak self] recipes, error in
			guard let self else { return }
			DispatchQueue.main.async {
				self.ui?.activityIndicator.stopAnimating()
			}
			if let recipes = recipes {
				self.model = recipes
				self.ui?.updateUI(with: recipes)
				completion(nil)
			} else if let error = error {
				completion(error)
			}
		}
	}
	
	func tapOnTheCell(recipe: Recipe?) {
		router?.showDetailRecipeViewController(recipe: recipe)
	}
	
	func saveRecipeToDatabase(recipe: Recipe) {
		if	RecipeDataManager.shared.isRecipeSaved(recipe){
			RecipeDataManager.shared.deleteRecipe(recipeId: Int(recipe.id))
		} else {
			RecipeDataManager.shared.saveRecipe(recipe: recipe)
		}
	}
}

extension SearchRecipesPresenter: ISearchRecipesPresenter{
	func viewDidLoad(ui: ISearchRecipesView) {
		self.ui = ui
		self.ui?.setDelegateDataSource(delegate: ui)
		guard let recipe = model else { return }
		self.ui?.updateUI(with: recipe)
	}
}
