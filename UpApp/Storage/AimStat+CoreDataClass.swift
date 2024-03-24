import CoreData


public class AimStat: NSManagedObject {    
    // MARK: Fetch
    static func fetchStat(stats: inout AimStat, context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<AimStat> = AimStat.fetchRequest()
        do {
            let results = try context.fetch(fetchRequest)
            if let firstResult = results.first {
                stats = firstResult
            } else {
                stats = AimStat(context: context)
                try context.save()
            }
        } catch {
            print("Error fetching aim stats: \(error)")
        }
    }
    
    // MARK: Save
    static func saveContext(context: NSManagedObjectContext) {
        do { try context.save() } catch { }
    }
}
