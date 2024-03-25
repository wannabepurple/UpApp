import CoreData


public class PerkStat: NSManagedObject {
    // MARK: Fetch
    static func fetchStat(stats: inout PerkStat?, context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<PerkStat> = PerkStat.fetchRequest()
           do {
               let res = try context.fetch(fetchRequest)
               if let firstStat = res.first {
                   stats = firstStat
               } else {
                   stats = PerkStat(context: context)
                   print("В базе данных нет объектов PerkStat")
               }
           } catch { }
    }
    
    // MARK: Save
    static func saveContext(context: NSManagedObjectContext) {
        do { try context.save() } catch { }
    }
}
