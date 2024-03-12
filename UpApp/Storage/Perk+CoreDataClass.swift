import UIKit
import CoreData


public class Perk: NSManagedObject {
    // MARK: Read
    // Fetch the data from Core Data to display on the tableView
    static func fetchPerks(perks: inout [Perk], context: NSManagedObjectContext) {
        do {
            perks = try context.fetch(Perk.fetchRequest())
            print(perks)
            print("end\n")
        } catch { }
    }
    
    // MARK: Save
    static func saveContext(context: NSManagedObjectContext) {
        do { try context.save() } catch { }
    }
    
    // MARK: Delete
    static func deletePerk(context: NSManagedObjectContext, perkToRemove: Perk) {
        context.delete(perkToRemove)
    }
    
}
