//import Foundation
import UIKit
import CoreData

@objc(PerkFromSession)
public class PerkFromSession: NSManagedObject {}

extension PerkFromSession: Identifiable {}

extension PerkFromSession {
    @NSManaged public var id: Int
    @NSManaged public var perkTitle: String
    @NSManaged public var lvl: String
    @NSManaged public var progress: Float
    @NSManaged public var toNextLvl: Float
}
