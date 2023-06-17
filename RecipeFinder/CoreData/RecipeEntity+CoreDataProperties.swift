import Foundation
import CoreData


extension RecipeEntity {
	
	@nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeEntity> {
		return NSFetchRequest<RecipeEntity>(entityName: "RecipeEntity")
	}
	
	@NSManaged public var id: Int32
	@NSManaged public var image: URL
	@NSManaged public var likes: Int32
	@NSManaged public var title: String
	@NSManaged public var missedIngredients: NSSet?
	@NSManaged public var usedIngredients: NSSet?
	
}

// MARK: Generated accessors for missedIngredients
extension RecipeEntity {
	
	@objc(addMissedIngredientsObject:)
	@NSManaged public func addToMissedIngredients(_ value: IngredientEntity)
	
	@objc(removeMissedIngredientsObject:)
	@NSManaged public func removeFromMissedIngredients(_ value: IngredientEntity)
	
	@objc(addMissedIngredients:)
	@NSManaged public func addToMissedIngredients(_ values: NSSet)
	
	@objc(removeMissedIngredients:)
	@NSManaged public func removeFromMissedIngredients(_ values: NSSet)
	
}

// MARK: Generated accessors for usedIngredients
extension RecipeEntity {
	
	@objc(addUsedIngredientsObject:)
	@NSManaged public func addToUsedIngredients(_ value: IngredientEntity)
	
	@objc(removeUsedIngredientsObject:)
	@NSManaged public func removeFromUsedIngredients(_ value: IngredientEntity)
	
	@objc(addUsedIngredients:)
	@NSManaged public func addToUsedIngredients(_ values: NSSet)
	
	@objc(removeUsedIngredients:)
	@NSManaged public func removeFromUsedIngredients(_ values: NSSet)
	
}

extension RecipeEntity : Identifiable {
	
}
