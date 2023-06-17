import UIKit

protocol IFavoriteRecipesView: AnyObject, UICollectionViewDelegate, UICollectionViewDataSource {
	func setDelegateDataSource(delegate: UICollectionViewDelegate & UICollectionViewDataSource)
	func updateUI(with data: [Recipe])
	func filterContentForSearchText(_ searchText: String)
	func removeAllRecipe()
}

final class FavoriteRecipesView: UIView {
	enum LayoutConstants {
		static let top: CGFloat = 8
		static let leading: CGFloat = 8
		static let trailing: CGFloat = 8
	}
	
	enum Metrics {
		static let collectionItemSize = CGSize(width: 185, height: 145)
		static let spacing: CGFloat = 0
	}
	
	var favoriteRecipes: [Recipe] = []
	var filteredData: [Recipe] = []
	var shouldShowFilteredResults = false
	var presenter: FavoriteRecipesPresenter?
	
	let favoriteCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumInteritemSpacing = Metrics.spacing
		layout.itemSize = Metrics.collectionItemSize
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		cv.translatesAutoresizingMaskIntoConstraints = false
		cv.backgroundColor = ColorStyle.systemBackground.color
		cv.showsVerticalScrollIndicator = false
		cv.register(FavoriteListCell.self, forCellWithReuseIdentifier: FavoriteListCell.identifier)
		return cv
	}()
	
	init() {
		super.init(frame: .zero)
		self.configureView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension FavoriteRecipesView: IFavoriteRecipesView {
	func setDelegateDataSource(delegate: UICollectionViewDelegate & UICollectionViewDataSource) {
		favoriteCollectionView.delegate = delegate
		favoriteCollectionView.dataSource = delegate
	}
	
	func updateUI(with data: [Recipe]) {
		favoriteRecipes = data
		favoriteCollectionView.reloadData()
	}
	
	func filterContentForSearchText(_ searchText: String) {
		shouldShowFilteredResults = !searchText.isEmpty
		filteredData = favoriteRecipes.filter({ (dataItem: Recipe) -> Bool in
			return dataItem.title.lowercased().contains(searchText.lowercased())
		})
		favoriteCollectionView.reloadData()
	}
	
	func removeAllRecipe() {
		favoriteRecipes = []
		favoriteCollectionView.reloadData()
	}
	
}

private extension FavoriteRecipesView {
	func configureView() {
		self.backgroundColor = ColorStyle.systemBackground.color
		self.addSubview(self.favoriteCollectionView)
		
		NSLayoutConstraint.activate([
			favoriteCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: LayoutConstants.top),
			favoriteCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: LayoutConstants.leading),
			favoriteCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -LayoutConstants.trailing),
			favoriteCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
		])
	}
}
