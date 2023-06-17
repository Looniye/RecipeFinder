import UIKit

final class RecipeListCell: UITableViewCell {
	enum Metrics {
		static let top: CGFloat = 8
		static let leading: CGFloat = 8
		static let trailing: CGFloat = 8
		static let bottom: CGFloat = 8
		static let recipeTitleLabelTrailing: CGFloat = 40
		static let likeCountLabelTrailing: CGFloat = 4
		
		static let recipeImageMulti: CGFloat = 0.5
		
		static let imageViewSize: CGSize = CGSize(width: 24, height: 24)
		static let fillViewSize: CGSize = CGSize(width: 32, height: 32)
	}
	
	static let identifier = "RecipeListCell"
	private var recipeId: Int = 0
	var onButtonTapped: (() -> Void)?
	
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
	
	private let fillView:  UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = ColorStyle.translucent.color
		view.layer.cornerRadius = AppConstants.Layer.cornerRadius
		return view
	}()
	
	private let recipeImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.layer.cornerRadius = AppConstants.Layer.cornerRadius
		imageView.clipsToBounds = true
		return imageView
	}()
	
	private lazy var recipeTitleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = AppConstants.Text.numberOFLines
		label.font = TextStyle.smallTitle.font
		return label
	}()
	
	private lazy var likeCountLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = TextStyle.smallLabel.font
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
	
	private lazy var favoriteRecipeButton: UIButton = {
		let button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(AppConstants.Image.favoriteRecipeButton, for: .normal)
		button.addTarget(self, action: #selector(favoriteRecipeButtonTapped), for: .touchUpInside)
		return button
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configureView()
		updateShadowColor(for: containerView)
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		updateShadowColor(for: containerView)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func toggleFavoriteButton(isSelected: Bool) {
		favoriteRecipeButton.isSelected = isSelected
		favoriteRecipeButton.tintColor = ColorStyle.orange.color
		
		if isSelected {
			favoriteRecipeButton.setImage(AppConstants.Image.favoriteRecipeButtonFill, for: .normal)
		} else {
			favoriteRecipeButton.setImage(AppConstants.Image.favoriteRecipeButton, for: .normal)
		}
	}
	
	func setFavoriteButtonState(recipeId: Int) {
		let isFavorite = FavoritesManager.shared.isRecipeFavorite(recipeId: recipeId)
		toggleFavoriteButton(isSelected: isFavorite)
	}
	
	@objc
	private func favoriteRecipeButtonTapped(_ sender: UIButton) {
		let isSelected = favoriteRecipeButton.isSelected
		toggleFavoriteButton(isSelected: !isSelected)
		FavoritesManager.shared.toggleFavorite(recipeId: recipeId)
		onButtonTapped?()
	}
	
	func configure(with recipe: Recipe) {
		recipeTitleLabel.text = recipe.title
		likeCountLabel.text = String(recipe.likes)
		recipeId = Int(recipe.id)
		let imageUrlString = recipe.image
		DispatchQueue.global().async {
			if let imageData = try? Data(contentsOf: imageUrlString),
			   let image = UIImage(data: imageData) {
				DispatchQueue.main.async {
					self.recipeImageView.image = image
				}
			}
		}
	}
}

private extension RecipeListCell {
	func configureView() {
		self.backgroundColor = ColorStyle.systemBackground.color
		
		contentView.addSubview(containerView)
		containerView.addSubview(recipeImageView)
		containerView.addSubview(fillView)
		fillView.addSubview(favoriteRecipeButton)
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
			
			fillView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Metrics.top),
			fillView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Metrics.trailing),
			fillView.widthAnchor.constraint(equalToConstant: Metrics.fillViewSize.width),
			fillView.heightAnchor.constraint(equalToConstant: Metrics.fillViewSize.height),
			favoriteRecipeButton.centerXAnchor.constraint(equalTo: fillView.centerXAnchor),
			favoriteRecipeButton.centerYAnchor.constraint(equalTo: fillView.centerYAnchor),
			
			likeImageView.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: -Metrics.trailing),
			likeImageView.centerYAnchor.constraint(equalTo: recipeTitleLabel.centerYAnchor),
			likeImageView.widthAnchor.constraint(equalToConstant: Metrics.imageViewSize.width),
			likeImageView.heightAnchor.constraint(equalToConstant: Metrics.imageViewSize.height),
			
			likeCountLabel.trailingAnchor.constraint(equalTo: likeImageView.leadingAnchor, constant: -Metrics.likeCountLabelTrailing),
			likeCountLabel.centerYAnchor.constraint(equalTo: recipeTitleLabel.centerYAnchor)
		])
	}
}

extension SearchRecipesView: UITableViewDataSource, UITableViewDelegate {
	
	// MARK: - UITableViewDataSource
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return searchRecipes.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeListCell.identifier, for: indexPath) as? RecipeListCell else {
			return UITableViewCell()
		}
		let item = searchRecipes[indexPath.row]
		let recipeId = item.id
		cell.setFavoriteButtonState(recipeId: Int(recipeId))
		cell.configure(with: item)
		cell.layer.cornerRadius = AppConstants.Layer.cornerRadius
		cell.selectionStyle = .none
		cell.onButtonTapped = {
			self.presenter?.saveRecipeToDatabase(recipe: item)
		}
		return cell
	}
	
	// MARK: - UITableViewDelegate
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let item = searchRecipes[indexPath.row]
		presenter?.tapOnTheCell(recipe: item)
	}
}
