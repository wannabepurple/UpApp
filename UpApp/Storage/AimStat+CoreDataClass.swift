import CoreData


public class AimStat: NSManagedObject {    
    // MARK: Fetch
    static func fetchStat(stats: inout AimStat?, context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<AimStat> = AimStat.fetchRequest()
           do {
               let res = try context.fetch(fetchRequest)
               if let firstStat = res.first {
                   stats = firstStat
               } else {
                   stats = AimStat(context: context)
                   print("В базе данных нет объектов AimStat")
               }
           } catch { }
    }
    
    // MARK: Save
    static func saveContext(context: NSManagedObjectContext) {
        do { try context.save() } catch { }
    }
}
