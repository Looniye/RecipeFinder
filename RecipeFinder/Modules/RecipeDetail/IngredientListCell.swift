import UIKit

final class IngredientListCell: UITableViewCell {
	
	enum Metrics {
		static let top: CGFloat = 8
		static let leading: CGFloat = 8
		static let trailing: CGFloat = 8
		static let bottom: CGFloat = 8
		
		static let likeCountLabelTrailing: CGFloat = 4
		
		static let imageViewSize: CGSize = CGSize(width: 24, height: 24)
		static let fillViewSize: CGSize = CGSize(width: 32, height: 32)
	}
	
	static let identifier = "IngredientListCell"
	
	private let containerView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .systemGray6
		view.layer.cornerRadius = AppConstants.Layer.cornerRadius
		view.layer.shadowOpacity = AppConstants.ShadowConstant.opacity
		view.layer.shadowOffset = AppConstants.ShadowConstant.offset
		view.layer.shadowRadius = AppConstants.ShadowConstant.radius
		view.layer.masksToBounds = false
		return view
	}()
	
	private let ingredientImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.layer.shadowOpacity = AppConstants.ShadowConstant.opacity
		imageView.layer.shadowOffset = AppConstants.ShadowConstant.offset
		imageView.layer.shadowRadius = AppConstants.ShadowConstant.radius
		imageView.layer.cornerRadius = AppConstants.Layer.cornerRadius
		imageView.image = AppConstants.Image.placeholderIngredientImage
		imageView.clipsToBounds = true
		return imageView
	}()
	
	private lazy var ingredientTitleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = AppConstants.Text.numberOFLines
		label.font = TextStyle.largeLabel.font
		label.numberOfLines = AppConstants.Text.numberOFLines
		return label
	}()
	
	private lazy var ingredientCountLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = TextStyle.smallLabel.font
		return label
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configureView()
		updateShadowColor(for: containerView)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(with ingredient: Ingredient) {
		ingredientTitleLabel.text = ingredient.original
		
		let imageUrlString = ingredient.image
		DispatchQueue.global().async {
			if let imageData = try? Data(contentsOf: imageUrlString),
			   let image = UIImage(data: imageData) {
				DispatchQueue.main.async {
					self.ingredientImageView.image = image
				}
			}
		}
	}
}

private extension IngredientListCell {
	func configureView() {
		self.backgroundColor = ColorStyle.systemBackground.color
		
		contentView.addSubview(containerView)
		containerView.addSubview(ingredientImageView)
		containerView.addSubview(ingredientTitleLabel)
		
		NSLayoutConstraint.activate([
			containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metrics.top),
			containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.leading),
			containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.trailing),
			containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Metrics.bottom),
			
			ingredientImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Metrics.top),
			ingredientImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Metrics.leading),
			ingredientImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Metrics.trailing),
			ingredientImageView.widthAnchor.constraint(equalTo: ingredientImageView.heightAnchor),
			
			ingredientTitleLabel.centerYAnchor.constraint(equalTo: ingredientImageView.centerYAnchor),
			ingredientTitleLabel.leadingAnchor.constraint(equalTo: ingredientImageView.trailingAnchor, constant: Metrics.leading),
			ingredientTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -Metrics.trailing),
			ingredientTitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Metrics.bottom)
		])
	}
}

extension DetailRecipeView: UITableViewDataSource {
	
	// MARK: - UITableViewDataSource
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return ingredients.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: IngredientListCell.identifier, for: indexPath) as? IngredientListCell else {
			return UITableViewCell()
		}
		let item = ingredients[indexPath.row]
		cell.configure(with: item)
		cell.layer.cornerRadius = AppConstants.Layer.cornerRadius
		cell.selectionStyle = .none
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return Metrics.heightForRowAt
	}
}
