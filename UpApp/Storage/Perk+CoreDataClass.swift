import UIKit
import CoreData


public class Perk: NSManagedObject {
    // MARK: Read
    // Fetch the data from Core Data to display on the tableView
    static func fetchPerks(perks: inout [Perk], context: NSManagedObjectContext) {
        do { perks = try context.fetch(Perk.fetchRequest()) } catch { }
    }
    
    static func fetchPerkWith(title: String, perk: inout [Perk], context: NSManagedObjectContext) {
        do {
            let request = Perk.fetchRequest() as NSFetchRequest<Perk>
            let predicate = NSPredicate(format: "perkTitle CONTAINS %@", title)
            request.predicate = predicate
            perk = try context.fetch(request)
        } catch { print("fetchPerkWith error")  } 
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
