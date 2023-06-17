import Foundation

final class RandomRecipeService {
	private let session = URLSession.shared
	static let shared = RandomRecipeService()
	
	func fetchRandomRecipe(completion: @escaping ([Recipe]?, Error?) -> Void) {
		let request = makeRequest()
		let task = self.session.objectTask(for: request) {  (result: Result<[Recipe], Error>) in
			DispatchQueue.main.async {
				switch result {
				case .success(let recipes):
					completion(recipes, nil)
				case .failure(let error):
					completion(nil, error)
				}
			}
		}
		task.resume()
	}
	
	private func makeRequest() -> URLRequest {
		guard let url = URL(string: DefaultBaseURL.absoluteString + "/recipes" + "/random?number=\(countRandomRecipe)" + "?apiKey=\(apiKey)") else { fatalError("Failed to create URL")}
		
		let request = URLRequest(url: url)
		return request
	}
}
