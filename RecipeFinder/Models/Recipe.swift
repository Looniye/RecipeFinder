import UIKit
import CoreData

struct Recipe: Codable {
	let id: Int32
	let title: String
	let image: URL
	let likes: Int32
	let usedIngredients: [Ingredient]
	let missedIngredients: [Ingredient]
	
	func convertToDatabaseRecipe(context: NSManagedObjectContext) -> RecipeEntity {
		let databaseRecipe = RecipeEntity(context: context)
		databaseRecipe.id = self.id
		databaseRecipe.title = self.title
		databaseRecipe.image = self.image
		databaseRecipe.likes = self.likes
		
		let usedIngredientsSet = NSSet(array: self.usedIngredients.map { $0.convertToDatabaseIngredient(context: context) })
		databaseRecipe.usedIngredients = usedIngredientsSet
		
		let missedIngredientsSet = NSSet(array: self.missedIngredients.map { $0.convertToDatabaseIngredient(context: context) })
		databaseRecipe.missedIngredients = missedIngredientsSet
		
		return databaseRecipe
	}
}
