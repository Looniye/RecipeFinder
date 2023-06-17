import Foundation

final class FavoritesManager {
	static let shared = FavoritesManager()
	
	private let favoritesKey = AppConstants.favoritesKey
	private var favorites: Set<Int> {
		get {
			if let favoritesData = UserDefaults.standard.data(forKey: favoritesKey),
			   let favoritesSet = try? JSONDecoder().decode(Set<Int>.self, from: favoritesData) {
				return favoritesSet
			}
			return Set<Int>()
		}
		set {
			if let favoritesData = try? JSONEncoder().encode(newValue) {
				UserDefaults.standard.set(favoritesData, forKey: favoritesKey)
			}
		}
	}
	
	func isRecipeFavorite(recipeId: Int) -> Bool {
		return favorites.contains(recipeId)
	}
	
	
	func toggleFavorite(recipeId: Int) {
		if isRecipeFavorite(recipeId: recipeId) {
			favorites.remove(recipeId)
		} else {
			favorites.insert(recipeId)
		}
	}
	
	func clearFavorites() {
		favorites = Set<Int>()
	}
}
