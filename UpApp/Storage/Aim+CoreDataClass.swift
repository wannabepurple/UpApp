import UIKit
import CoreData

public class Aim: NSManagedObject {
    // MARK: Read
    static func fetchAims(aims: inout [Aim], context: NSManagedObjectContext) {
        do { aims = try context.fetch(Aim.fetchRequest()) } catch { }
    }
    
    // MARK: Save
    static func saveContext(context: NSManagedObjectContext) {
        do { try context.save() } catch { }
    }
    
    // MARK: Delete
    static func deleteAim(context: NSManagedObjectContext, aimToRemove: Aim) {
        context.delete(aimToRemove)
    }
}
