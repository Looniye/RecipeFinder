import UIKit

final class FavoriteListCell: UICollectionViewCell {
	enum Metrics {
		static let top: CGFloat = 8
		static let leading: CGFloat = 8
		static let trailing: CGFloat = 8
		static let bottom: CGFloat = 8
		static let recipeTitleLabelTrailing: CGFloat = 40
		static let likeCountLabelTrailing: CGFloat = 4
		static let recipeImageMulti: CGFloat = 0.5
		
		static let imageViewSize: CGSize = CGSize(width: 18, height: 18)
	}
	
	static let identifier = "FavoriteListCell"
	
	private let containerView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = ColorStyle.systemBackground.color
		view.layer.cornerRadius = AppConstants.Layer.cornerRadius
		view.layer.shadowOpacity = AppConstants.ShadowConstant.opacity
		view.layer.shadowOffset = AppConstants.ShadowConstant.offset
		view.layer.shadowRadius = AppConstants.ShadowConstant.radius
		view.layer.masksToBounds = false
		return view
	}()
	
	private let recipeImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.image = AppConstants.Image.placeholderRecipeImage
		imageView.layer.cornerRadius = AppConstants.Layer.cornerRadius
		imageView.clipsToBounds = true
		return imageView
	}()
	
	private lazy var recipeTitleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = AppConstants.Text.numberOFLines
		label.font = TextStyle.mini.font
		return label
	}()
	
	private lazy var likeCountLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = TextStyle.mini.font
		label.textColor = ColorStyle.red.color
		return label
	}()
	
	private let likeImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = true
		imageView.image = AppConstants.Image.likeImageView
		imageView.tintColor = ColorStyle.red.color
		return imageView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureView()
		updateShadowColor(for: containerView)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		updateShadowColor(for: containerView)
	}
	
	func configure(with recipe: Recipe) {
		let imageURLString = recipe.image
		DispatchQueue.global().async {
			if let imageData = try? Data(contentsOf: imageURLString) {
				let image = UIImage(data: imageData)
				DispatchQueue.main.async {
					self.recipeImageView.image = image
				}
			}
		}
		recipeTitleLabel.text = recipe.title
		likeCountLabel.text = String(recipe.likes)
	}
}

private extension FavoriteListCell {
	func configureView() {
		self.backgroundColor = ColorStyle.systemBackground.color
		
		contentView.addSubview(containerView)
		containerView.addSubview(recipeImageView)
		containerView.addSubview(recipeTitleLabel)
		containerView.addSubview(likeCountLabel)
		containerView.addSubview(likeImageView)
		
		NSLayoutConstraint.activate([
			containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metrics.top),
			containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.leading),
			containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.trailing),
			containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Metrics.bottom),
			
			recipeImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
			recipeImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
			recipeImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
			recipeImageView.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: Metrics.recipeImageMulti),
			
			recipeTitleLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: Metrics.top),
			recipeTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Metrics.leading),
			recipeTitleLabel.trailingAnchor.constraint(equalTo: likeImageView.leadingAnchor, constant: -Metrics.recipeTitleLabelTrailing),
			recipeTitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Metrics.bottom),
			
			likeImageView.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: -Metrics.trailing),
			likeImageView.centerYAnchor.constraint(equalTo: recipeTitleLabel.centerYAnchor),
			likeImageView.widthAnchor.constraint(equalToConstant: Metrics.imageViewSize.width),
			likeImageView.heightAnchor.constraint(equalToConstant: Metrics.imageViewSize.height),
			
			likeCountLabel.trailingAnchor.constraint(equalTo: likeImageView.leadingAnchor, constant: -Metrics.likeCountLabelTrailing),
			likeCountLabel.centerYAnchor.constraint(equalTo: recipeTitleLabel.centerYAnchor)
		])
	}
}

extension FavoriteRecipesView: UICollectionViewDataSource, UICollectionViewDelegate {
	
	// MARK: - UITableViewDataSource
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if shouldShowFilteredResults {
			return filteredData.count
		} else {
			return favoriteRecipes.count
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteListCell.identifier, for: indexPath) as? FavoriteListCell else {
			return UICollectionViewCell()
		}
		let dataItem: Recipe
		
		if shouldShowFilteredResults {
			dataItem = filteredData[indexPath.row]
			cell.configure(with: dataItem)
		} else {
			dataItem = favoriteRecipes[indexPath.row]
			cell.configure(with: dataItem)
		}
		
		cell.layer.cornerRadius = AppConstants.Layer.cornerRadius
		
		return cell
	}
	
	// MARK: - UITableViewDelegate
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let item = favoriteRecipes[indexPath.row]
		presenter?.tapOnTheCell(recipe: item)
	}
	func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
		configureContextMenu(index: indexPath.row)
	}
	
	func configureContextMenu(index: Int) -> UIContextMenuConfiguration {
		let context = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (action) -> UIMenu? in
			
			let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), identifier: nil, discoverabilityTitle: nil,attributes: .destructive, state: .off) { (_) in
				let dataItem = self.favoriteRecipes[index].id
				RecipeDataManager.shared.deleteRecipe(recipeId: Int(dataItem))
				self.favoriteRecipes.remove(at: index)
				FavoritesManager.shared.toggleFavorite(recipeId: Int(dataItem))
				self.favoriteCollectionView.reloadData()
			}
			
			return UIMenu(title: "", image: nil, identifier: nil, options: UIMenu.Options.displayInline, children: [delete])
			
		}
		return context
	}
}
