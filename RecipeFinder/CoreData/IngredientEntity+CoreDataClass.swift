import Foundation
import CoreData


public class IngredientEntity: NSManagedObject {

}
extension IngredientEntity {
	func convertToDatabaseIngredient(context: NSManagedObjectContext) -> Ingredient {
		let ingredient = Ingredient(id: self.id,
									name: self.name,
									image: self.image,
									original: self.original)
		return ingredient
	}
}
