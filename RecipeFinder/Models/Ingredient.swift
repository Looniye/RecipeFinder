import UIKit
import CoreData

struct Ingredient: Codable {
	let id: Int32
	let name: String
	let image: URL
	let original: String
	
	func convertToDatabaseIngredient(context: NSManagedObjectContext) -> IngredientEntity {
		let databaseIngredient = IngredientEntity(context: context)
		databaseIngredient.id = self.id
		databaseIngredient.name = self.name
		databaseIngredient.image = self.image
		databaseIngredient.original = self.original
		return databaseIngredient
	}
}
