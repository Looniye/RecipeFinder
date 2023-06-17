import UIKit

protocol ISearchRecipesView: AnyObject, UITableViewDelegate, UITableViewDataSource {
	func setDelegateDataSource(delegate: UITableViewDelegate & UITableViewDataSource)
	func updateUI(with data: [Recipe])
	func updateTable()
	var activityIndicator: UIActivityIndicatorView { get }
}

final class SearchRecipesView: UIView {
	enum LayoutConstants {
		static let top: CGFloat = 8
		static let leading: CGFloat = 8
		static let trailing: CGFloat = 8
	}
	
	var searchRecipes: [Recipe] = []
	var presenter: SearchRecipesPresenter?
	
	lazy var recipeTableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .plain)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.separatorStyle = .none
		tableView.showsVerticalScrollIndicator = false
		tableView.register(RecipeListCell.self, forCellReuseIdentifier: RecipeListCell.identifier)
		return tableView
	}()
	
	let activityIndicator: UIActivityIndicatorView = {
		let activityIndicator = UIActivityIndicatorView(style: .large)
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		return activityIndicator
	}()
	
	init() {
		super.init(frame: .zero)
		self.configureView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension SearchRecipesView: ISearchRecipesView {
	func setDelegateDataSource(delegate: UITableViewDelegate & UITableViewDataSource) {
		recipeTableView.delegate = delegate
		recipeTableView.dataSource = delegate
	}
	
	func updateUI(with data: [Recipe]) {
		searchRecipes = data
		DispatchQueue.main.async { [weak self] in
			guard let self else { return }
			self.recipeTableView.reloadData()
		}
	}
	
	func updateTable(){
		recipeTableView.reloadData()
	}
}

private extension SearchRecipesView {
	func configureView() {
		self.backgroundColor = ColorStyle.systemBackground.color
		self.addSubview(self.recipeTableView)
		self.addSubview(activityIndicator)
		
		NSLayoutConstraint.activate([
			recipeTableView.topAnchor.constraint(equalTo: self.topAnchor, constant: LayoutConstants.top),
			recipeTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: LayoutConstants.leading),
			recipeTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -LayoutConstants.trailing),
			recipeTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			
			activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
		])
	}
}
