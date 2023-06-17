protocol IDetailRecipePresenter {
	func viewDidLoad(ui: IDetailRecipeView)
}

final class DetailRecipePresenter {
	private var ui: IDetailRecipeView?
	private var model: Recipe?
	
	init(recipe: Recipe?) {
		self.model = recipe
	}
}

extension DetailRecipePresenter: IDetailRecipePresenter{
	func viewDidLoad(ui: IDetailRecipeView) {
		self.ui = ui
		self.ui?.setDelegateDataSource(delegate: ui)
		guard let recipe = model else { return }
		self.ui?.updateUI(with: recipe)
	}
}
