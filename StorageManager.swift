import CoreData
import UIKit

// MARK: CRUD - copy, read, update, delete

public final class StorageManager: NSObject {
    // Singletone
    public static let shared = StorageManager()
    private override init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    // MARK: Create
    public func createPerk(id: Int, perkTitle: String, lvl: String, progress: Float, toNextLvl: Float) {
        guard let perkEntityDescription = NSEntityDescription.entity(forEntityName: "PerkFromSession", in: context) else { return }
        let perk = PerkFromSession(entity: perkEntityDescription, insertInto: context)
        perk.id = id
        perk.perkTitle = perkTitle
        perk.lvl = lvl
        perk.progress = progress
        perk.toNextLvl = toNextLvl
        
        appDelegate.saveContext()
    }
    
    // MARK: Read
    // Read all perks
    public func readPerks() -> [PerkFromSession] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PerkFromSession")
        do {
            return (try? context.fetch(fetchRequest) as? [PerkFromSession]) ?? []
        }
    }
    
    // Read 1 perk
    public func readPerk(id: Int) -> PerkFromSession? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PerkFromSession")
        do {
            let perks = try? context.fetch(fetchRequest) as? [PerkFromSession]
            return perks?.first(where: { $0.id == id })
        }
    }
    
    // MARK: Update
    public func updatePerk(id: Int, perkTitle: String, lvl: String, progress: Float, toNextLvl: Float) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PerkFromSession")
        do {
            guard let perks = try? context.fetch(fetchRequest) as? [PerkFromSession],
                  let perk = perks.first(where: { $0.id == id }) else { return }
            perk.perkTitle = perkTitle
            perk.lvl = lvl
            perk.progress = progress
            perk.toNextLvl = toNextLvl
        }
        
        appDelegate.saveContext()
    }
    
    // MARK: Delete
    public func deleteAllPerks() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PerkFromSession")
        do {
            let perks = try? context.fetch(fetchRequest) as? [PerkFromSession]
            perks?.forEach { context.delete($0) }
        }
        
        appDelegate.saveContext()
    }
    
    public func deletePerk(id: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PerkFromSession")
        do {
            guard let perks = try? context.fetch(fetchRequest) as? [PerkFromSession],
                  let perk = perks.first(where: { $0.id == id }) else { return }
            context.delete(perk)
        }
    }
}

