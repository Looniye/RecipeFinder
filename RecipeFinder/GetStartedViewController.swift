import UIKit

final class GetStartedViewController: UIViewController {
	enum LayoutConstants {
		static let centerYLabel: CGFloat = 30
		static let leadingAndTrailingButton: CGFloat = 40
		static let leadingAndTrailingLabel: CGFloat = 16
		static let bottomAnchorLabel: CGFloat = 16
		static let height: CGFloat = 50
	}
	
	weak var delegate: SceneDelegate?
	
	let imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.image = AppConstants.Image.getStartedImage
		return imageView
	}()
	
	lazy var getStartedTitleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = AppConstants.Text.getStartedTitleLabel
		label.numberOfLines = AppConstants.Text.numberOFLines
		label.textColor = ColorStyle.white.color
		label.numberOfLines = AppConstants.Text.numberOFLines
		label.font = TextStyle.ultraBig.font
		label.textAlignment = .center
		return label
	}()
	
	lazy var continueButton: UIButton = {
		let button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.backgroundColor = ColorStyle.orange.color
		button.layer.cornerRadius = AppConstants.Layer.cornerRadius
		button.setTitle(AppConstants.Text.buttonGetStartedTitle, for: .normal)
		button.setTitleColor(ColorStyle.white.color, for: .normal)
		button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
		button.clipsToBounds = true
		return button
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
	}
	
	@objc func continueButtonTapped() {
		delegate?.showTabBarController()
		UserDefaults.standard.set(true, forKey: AppConstants.isGetStartedShownKey)
	}
}

private extension GetStartedViewController {
	func configureUI() {
		view.addSubview(imageView)
		view.addSubview(continueButton)
		view.addSubview(getStartedTitleLabel)
		
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: view.topAnchor),
			imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			
			getStartedTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			getStartedTitleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -LayoutConstants.centerYLabel),
			getStartedTitleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: LayoutConstants.leadingAndTrailingLabel),
			getStartedTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -LayoutConstants.leadingAndTrailingLabel),
			
			continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstants.leadingAndTrailingButton),
			continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstants.leadingAndTrailingButton),
			continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -LayoutConstants.bottomAnchorLabel),
			continueButton.heightAnchor.constraint(equalToConstant: LayoutConstants.height)
		])
	}
}
