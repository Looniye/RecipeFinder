import UIKit

let DefaultBaseURL = URL(string: "https://api.spoonacular.com")!
let apiKey = "28ff86584f9e48c19f626bc6ba9466e2"
let apiKeyTwo = "83d4d86712c34236aa22e1464bd698a5"
let countRandomRecipe = 10

struct AppConstants {
	static let isGetStartedShownKey = "isGetStartedShown14"
	static let favoritesKey = "Favorites"
	
	struct Image {
		static let likeImageView = UIImage(systemName: "heart.fill")
		static let favoriteRecipeButton = UIImage(systemName: "bookmark")
		static let favoriteRecipeButtonFill = UIImage(systemName: "bookmark.fill")
		static let getStartedImage = UIImage(named: "GetStartedImage")
		static let placeholderRecipeImage = UIImage(named: "PlaceholderRecipeImage")
		static let placeholderIngredientImage = UIImage(named: "PlaceholderIngredientImage")
	}
	
	struct Text {
		static let titleLabelText = "Let's Cooking"
		static let searchBarPlaceholder = "Search by ingredients"
		static let favoriteSearchBarPlaceholder = "Search saved recipe"
		static let ingredientsLabel = "Ingredients"
		static let getStartedTitleLabel = "Food Recipes"
		static let getStartedSubtitleLabel = "Easy To Make Food"
		static let buttonGetStartedTitle = "Get Started"
		static let numberOFLines: Int = 0
	}
	
	struct NavigationTitle {
		static let home = "Let's Cooking"
		static let favorites = "Saved Recipe"
	}
	
	struct TabBarTitle {
		static let home = "Home"
		static let favorites = "Favorite"
	}
	
	struct TabBarImage {
		static let home = UIImage(systemName: "house")
		static let favorites = UIImage(systemName: "bookmark")
	}
	
	struct Layer {
		static let cornerRadius: CGFloat = 16.0
	}
	
	struct ShadowConstant {
		static let opacity: Float = 0.5
		static let offset = CGSize(width: 0, height: 2)
		static let radius: CGFloat = 4
	}
}
