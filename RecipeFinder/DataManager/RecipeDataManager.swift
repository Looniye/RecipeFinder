import UIKit
import CoreData


final class RecipeDataManager {
	static let shared = RecipeDataManager()
	
	private init(){}
	
	let context = CoreDataStack.shared.managedObjectContext
	
	func saveRecipe(recipe: Recipe) {
		let recipeEntity = recipe.convertToDatabaseRecipe(context: context)
		
		do {
			try context.save()
		} catch let error as NSError {
			print("Не удалось сохранить запись Recipe. Ошибка: \(error), \(error.userInfo)")
		}
	}
	
	func loadRecipes() -> [Recipe] {
		var recipes: [Recipe] = []
		
		let fetchRequest: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
		
		do {
			let recipeEntities = try context.fetch(fetchRequest)
			
			for recipeEntity in recipeEntities {
				let recipe = recipeEntity.convertToDatabaseRecipe(context: context)
				recipes.append(recipe)
			}
		} catch let error as NSError {
			print("Ошибка при загрузке данных из CoreData: \(error), \(error.userInfo)")
		}
		
		return recipes
	}
	
	
	func deleteRecipe(recipeId: Int) {
		let fetchRequest: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "id == %@", NSNumber(value: recipeId))
		
		do {
			let recipes = try context.fetch(fetchRequest)
			if let recipe = recipes.first {
				context.delete(recipe)
				try context.save()
			}
			
		} catch let error as NSError {
			print("Ошибка при удалении рецепта из Core Data: \(error), \(error.userInfo)")
		}
	}
	
	func deleteAllData() {
		let recipeFetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "RecipeEntity")
		let recipeDeleteRequest = NSBatchDeleteRequest(fetchRequest: recipeFetchRequest)
		
		let ingredientFetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "IngredientEntity")
		let ingredientDeleteRequest = NSBatchDeleteRequest(fetchRequest: ingredientFetchRequest)
		
		do {
			try context.execute(recipeDeleteRequest)
			try context.execute(ingredientDeleteRequest)
			save()
		} catch let error as NSError {
			print("Ошибка при удалении рецепта из Core Data: \(error), \(error.userInfo)")
		}
	}
	
	func save() {
		CoreDataStack.shared.saveContext()
	}
	
	func isRecipeSaved(_ recipe: Recipe) -> Bool {
		let fetchRequest: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "id == %@", NSNumber(value: recipe.id))
		
		do {
			let recipes = try context.fetch(fetchRequest)
			return !recipes.isEmpty
		} catch let error as NSError {
			print("Ошибка при проверке сохранения рецепта: \(error), \(error.userInfo)")
			return false
		}
	}
}
