import Foundation
import CoreData


extension PerkStorage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PerkStorage> {
        return NSFetchRequest<PerkStorage>(entityName: "PerkStorage")
    }

    @NSManaged public var id: Int16
    @NSManaged public var lvl: Int16
    @NSManaged public var perkTitle: String?
    @NSManaged public var progress: Float
    @NSManaged public var toNextLvl: Float

}

extension PerkStorage : Identifiable {

}
