import Foundation
import CoreData


extension IngredientEntity {
	
	@nonobjc public class func fetchRequest() -> NSFetchRequest<IngredientEntity> {
		return NSFetchRequest<IngredientEntity>(entityName: "IngredientEntity")
	}
	
	@NSManaged public var id: Int32
	@NSManaged public var image: URL
	@NSManaged public var name: String
	@NSManaged public var original: String
	@NSManaged public var missedIngredients: NSSet?
	@NSManaged public var usedIngredients: NSSet?
	
}

// MARK: Generated accessors for missedIngredients
extension IngredientEntity {
	
	@objc(addMissedIngredientsObject:)
	@NSManaged public func addToMissedIngredients(_ value: RecipeEntity)
	
	@objc(removeMissedIngredientsObject:)
	@NSManaged public func removeFromMissedIngredients(_ value: RecipeEntity)
	
	@objc(addMissedIngredients:)
	@NSManaged public func addToMissedIngredients(_ values: NSSet)
	
	@objc(removeMissedIngredients:)
	@NSManaged public func removeFromMissedIngredients(_ values: NSSet)
	
}

// MARK: Generated accessors for usedIngredients
extension IngredientEntity {
	
	@objc(addUsedIngredientsObject:)
	@NSManaged public func addToUsedIngredients(_ value: RecipeEntity)
	
	@objc(removeUsedIngredientsObject:)
	@NSManaged public func removeFromUsedIngredients(_ value: RecipeEntity)
	
	@objc(addUsedIngredients:)
	@NSManaged public func addToUsedIngredients(_ values: NSSet)
	
	@objc(removeUsedIngredients:)
	@NSManaged public func removeFromUsedIngredients(_ values: NSSet)
	
}

extension IngredientEntity : Identifiable {
	
}
