import UIKit
import CoreData


public class AimStat: NSManagedObject {
    // MARK: Read
    static func fetchStats(stats: inout [AimStat], context: NSManagedObjectContext) {
        do { stats = try context.fetch(AimStat.fetchRequest()) } catch { }
    }
    
    // MARK: Save
    static func saveContext(context: NSManagedObjectContext) {
        do { try context.save() } catch { }
    }
    
    // MARK: Delete
    static func deleteAim(context: NSManagedObjectContext, aimToRemove: AimStat) {
        context.delete(aimToRemove)
    }
}
