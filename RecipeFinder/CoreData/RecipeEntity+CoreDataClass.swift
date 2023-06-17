import Foundation
import CoreData


public class RecipeEntity: NSManagedObject {

}
extension RecipeEntity {
	func convertToDatabaseRecipe(context: NSManagedObjectContext) -> Recipe {
		var usedIngredients: [Ingredient] = []
		var missedIngredients: [Ingredient] = []
		
		if let usedIngredientEntities = self.usedIngredients as? Set<IngredientEntity> {
			usedIngredients = usedIngredientEntities.map { $0.convertToDatabaseIngredient(context: context) }
		}
		
		if let missedIngredientEntities = self.missedIngredients as? Set<IngredientEntity> {
			missedIngredients = missedIngredientEntities.map { $0.convertToDatabaseIngredient(context: context) }
		}
		
		let recipe = Recipe(id: self.id,
							title: self.title,
							image: self.image,
							likes: self.likes,
							usedIngredients: usedIngredients,
							missedIngredients: missedIngredients)
		
		return recipe
	}
}
