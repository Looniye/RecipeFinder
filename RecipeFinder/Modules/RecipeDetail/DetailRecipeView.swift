import UIKit

protocol IDetailRecipeView: AnyObject, UITableViewDelegate, UITableViewDataSource {
	func setDelegateDataSource(delegate: UITableViewDelegate & UITableViewDataSource)
	func updateUI(with data: Recipe)
}

final class DetailRecipeView: UIView {
	enum Metrics {
		static let top: CGFloat = 16
		static let leading: CGFloat = 16
		static let trailing: CGFloat = 16
		static let bottom: CGFloat = 16
		
		static let imageMultiplier: CGFloat = 0.5
		static let heightForRowAt: CGFloat = 75
		static let tableViewHeight: CGFloat = 400
	}
	
	var ingredients: [Ingredient] = []
	private var recipe: Recipe?
	
	private let scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		return scrollView
	}()
	
	private let contentView: UIView = {
		let contentView = UIView()
		contentView.translatesAutoresizingMaskIntoConstraints = false
		return contentView
	}()
	
	private lazy var recipeTitleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = AppConstants.Text.numberOFLines
		label.font = TextStyle.bigTitle.font
		return label
	}()
	
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
		imageView.layer.cornerRadius = AppConstants.Layer.cornerRadius
		imageView.image = AppConstants.Image.placeholderRecipeImage
		imageView.clipsToBounds = true
		return imageView
	}()
	
	private lazy var ingredientsLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = AppConstants.Text.numberOFLines
		label.font = TextStyle.miniBigTitle.font
		label.text = AppConstants.Text.ingredientsLabel
		return label
	}()
	
	private lazy var ingredientsCountLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = AppConstants.Text.numberOFLines
		label.font = TextStyle.miniBigTitle.font
		return label
	}()
	
	private lazy var ingredientTableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .plain)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.separatorStyle = .none
		tableView.showsVerticalScrollIndicator = false
		tableView.register(IngredientListCell.self, forCellReuseIdentifier: IngredientListCell.identifier)
		return tableView
	}()
	
	private lazy var instructionsLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = AppConstants.Text.numberOFLines
		label.font = TextStyle.largeLabel.font
		return label
	}()
	
	init() {
		super.init(frame: .zero)
		self.configureView()
		updateShadowColor(for: containerView)
	}
	
	func configure() {
		let imageUrlString = recipe?.image
		guard let url = imageUrlString else { return }
		DispatchQueue.global().async {
			if let imageData = try? Data(contentsOf: url),
			   let image = UIImage(data: imageData) {
				DispatchQueue.main.async {
					self.recipeImageView.image = image
				}
			}
		}
		recipeTitleLabel.text = recipe?.title
		let usedIngredientsCount = recipe?.usedIngredients.count ?? 0
		let missedIngredientsCount = recipe?.missedIngredients.count ?? 0
		let totalCount = usedIngredientsCount + missedIngredientsCount
		
		self.ingredientsCountLabel.text = "\(totalCount)"
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension DetailRecipeView: IDetailRecipeView {
	func setDelegateDataSource(delegate: UITableViewDelegate & UITableViewDataSource) {
		ingredientTableView.dataSource = delegate
		ingredientTableView.delegate = delegate
	}
	
	func updateUI(with data: Recipe) {
		recipe = data
		ingredients = data.usedIngredients + data.missedIngredients
		configure()
		ingredientTableView.reloadData()
	}
}

private extension DetailRecipeView {
	func configureView() {
		self.backgroundColor = ColorStyle.systemBackground.color
		self.addSubview(scrollView)
		scrollView.addSubview(contentView)
		contentView.addSubview(recipeTitleLabel)
		contentView.addSubview(containerView)
		containerView.addSubview(recipeImageView)
		contentView.addSubview(ingredientsLabel)
		contentView.addSubview(ingredientsCountLabel)
		contentView.addSubview(ingredientTableView)
		
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: self.topAnchor),
			scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			
			contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
			contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
			contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
			
			recipeTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metrics.top),
			recipeTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.leading),
			recipeTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.trailing),
			
			containerView.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor, constant: Metrics.top),
			containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.leading),
			containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.trailing),
			
			recipeImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
			recipeImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
			recipeImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
			recipeImageView.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: Metrics.imageMultiplier),
			
			ingredientsLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: Metrics.top),
			ingredientsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.leading),
			ingredientsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.trailing),
			
			ingredientsCountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.trailing),
			ingredientsCountLabel.centerYAnchor.constraint(equalTo: ingredientsLabel.centerYAnchor),
			
			ingredientTableView.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: Metrics.bottom),
			ingredientTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.leading),
			ingredientTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.trailing),
			ingredientTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Metrics.bottom),
			ingredientTableView.heightAnchor.constraint(equalToConstant: Metrics.tableViewHeight)
		])
	}
}
