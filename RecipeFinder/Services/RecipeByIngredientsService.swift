import Foundation

final class RecipeByIngredientsService {
	private let session = URLSession.shared
	static let shared = RecipeByIngredientsService()
	
	func fetchRecipeByIngredients(ingredients: [String], completion: @escaping ([Recipe]?, Error?) -> Void) {
		let request = makeRequest(with: ingredients)
		let task = self.session.objectTask(for: request) {  (result: Result<[Recipe], Error>) in
			DispatchQueue.main.async {
				switch result {
				case .success(let recipes):
					if recipes.isEmpty {
						let error = NSError(domain: "No recipes found", code: 0, userInfo: nil)
						completion(nil, error)
					} else {
						completion(recipes, nil)
					}
				case .failure(let error):
					completion(nil, error)
				}
			}
		}
		task.resume()
	}
	
	private func makeRequest(with ingredients: [String]) -> URLRequest {
		let escapedIngredients = ingredients.map { $0.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "" }
		let joinedIngredients = escapedIngredients.joined(separator: ",")
		
		guard let url = URL(string: DefaultBaseURL.absoluteString + "/recipes/" + "/findByIngredients" + "?apiKey=\(apiKey)" + "&ingredients=\(joinedIngredients)") else { fatalError("Failed to create URL")}
		
		let request = URLRequest(url: url)
		return request
	}
}
