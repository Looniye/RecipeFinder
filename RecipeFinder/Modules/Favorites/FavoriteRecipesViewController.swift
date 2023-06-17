import UIKit

final class FavoriteRecipesViewController: UIViewController {
	private let customView = FavoriteRecipesView()
	private var deleteButton: UIBarButtonItem?
	private var searchController: UISearchController?
	private let recipeDataManager = RecipeDataManager.shared
	private let favoritesManager = FavoritesManager.shared
	var favoriteRecipesPresenter: FavoriteRecipesPresenter
	
	init(with presenter: FavoriteRecipesPresenter) {
		self.favoriteRecipesPresenter = presenter
		super.init(nibName: nil, bundle: nil)
	}
	
	override func loadView() {
		self.view = self.customView
		setupNavigationController()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.favoriteRecipesPresenter.viewDidLoad(ui: self.customView)
		customView.presenter = favoriteRecipesPresenter
		setupNavigationController()
		configureNavigationBar()
		setupSearchController()
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.navigationBar.prefersLargeTitles = true
		self.favoriteRecipesPresenter.viewWillAppear(ui: self.customView)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension FavoriteRecipesViewController {
	func configureNavigationBar() {
		deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteButtonTapped))
		navigationItem.rightBarButtonItem = deleteButton
	}
	
	func setupNavigationController() {
		navigationItem.hidesSearchBarWhenScrolling = false
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.title = AppConstants.NavigationTitle.favorites
	}
	
	func setupSearchController() {
		searchController = UISearchController(searchResultsController: nil)
		searchController?.searchBar.delegate = self
		searchController?.searchBar.placeholder = AppConstants.Text.favoriteSearchBarPlaceholder
		navigationItem.searchController = searchController
		definesPresentationContext = true
	}
	
	func alertDeletion() {
		let alert = UIAlertController(title: "Warning", message: "Are you sure you want to remove all favorites?", preferredStyle: .alert)
		let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
			guard let self = self else { return }
			self.recipeDataManager.deleteAllData()
			self.favoritesManager.clearFavorites()
			self.favoriteRecipesPresenter.ui?.removeAllRecipe()
		}
		alert.addAction(deleteAction)
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		alert.addAction(cancelAction)
		self.present(alert, animated: true)
	}
	
	@objc func deleteButtonTapped() {
		alertDeletion()
	}
}

extension FavoriteRecipesViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		favoriteRecipesPresenter.ui?.filterContentForSearchText(searchText)
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		favoriteRecipesPresenter.ui?.filterContentForSearchText("")
	}
}
