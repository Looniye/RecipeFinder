import UIKit

final class SearchRecipesViewController: UIViewController {
	private let customView = SearchRecipesView()
	private var searchController: UISearchController?
	var searchRecipesPresenter: SearchRecipesPresenter
	
	init(with presenter: SearchRecipesPresenter) {
		self.searchRecipesPresenter = presenter
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		self.view = self.customView
		setupNavigationController()
		setupSearchController()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		searchRecipesPresenter.viewDidLoad(ui: self.customView)
		customView.presenter = searchRecipesPresenter
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		searchRecipesPresenter.ui?.updateTable()
	}
	
	func showAlert(title: String, message: String) {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		present(alertController, animated: true, completion: nil)
	}
}

private extension SearchRecipesViewController {
	func setupSearchController() {
		searchController = UISearchController(searchResultsController: nil)
		searchController?.searchBar.delegate = self
		searchController?.searchBar.placeholder = AppConstants.Text.searchBarPlaceholder
		navigationItem.searchController = searchController
		definesPresentationContext = true
	}
	
	func setupNavigationController() {
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.title = AppConstants.NavigationTitle.home
	}
}

extension SearchRecipesViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let searchIngredients = getSearchIngredients() else { return }
		searchRecipes(with: searchIngredients)
	}
	
	private func getSearchIngredients() -> [String]? {
		guard let text = searchController?.searchBar.text, !text.isEmpty else {
			return nil
		}
		let ingredients = text.components(separatedBy: ",")
		let trimmedIngredients = ingredients.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
		let validIngredients = trimmedIngredients.filter { !$0.isEmpty }
		
		return validIngredients
	}
	
	private func searchRecipes(with ingredients: [String]) {
		searchRecipesPresenter.getRecipes(with: ingredients) { [weak self] error in
			if error != nil {
				self?.showAlert(title: "Error", message: "Ingredient not found")
			}
		}
	}
}
