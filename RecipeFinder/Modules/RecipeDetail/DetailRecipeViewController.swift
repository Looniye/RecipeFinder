import UIKit

final class DetailRecipeViewController: UIViewController {
	private let customView = DetailRecipeView()
	var detailRecipePresenter: DetailRecipePresenter
	
	init(with presenter: DetailRecipePresenter) {
		self.detailRecipePresenter = presenter
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		self.view = self.customView
		navigationItem.largeTitleDisplayMode = .never
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.detailRecipePresenter.viewDidLoad(ui: self.customView)
	}
}
