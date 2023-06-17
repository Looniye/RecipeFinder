import Foundation
import CoreData

class CoreDataStack {
	static let shared = CoreDataStack()
	
	private init() {}
	
	lazy var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "RecipeFinder")
		container.loadPersistentStores(completionHandler: { (_, error) in
			if let error = error as NSError? {
				print("Ошибка инициализации Core Data: \(error), \(error.userInfo)")
			}
		})
		return container
	}()
	
	lazy var managedObjectContext: NSManagedObjectContext = {
		return persistentContainer.viewContext
	}()
	
	func saveContext () {
		if managedObjectContext.hasChanges {
			do {
				try managedObjectContext.save()
			} catch {
				let nserror = error as NSError
				fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
			}
		}
	}
}
