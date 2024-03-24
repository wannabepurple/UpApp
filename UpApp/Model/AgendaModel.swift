import UIKit
import CoreData

class AgendaModel {
    static var completedAims: Int64 = 0

    
    static func createNewAim(context: NSManagedObjectContext) {
        _ = Aim(context: context)
        Aim.saveContext(context: context)
    }
}
