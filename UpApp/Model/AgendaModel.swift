import UIKit
import CoreData

class AgendaModel {
    static func createNewAim(context: NSManagedObjectContext) {
        let newAim = Aim(context: context)
        Aim.saveContext(context: context)
    }
}
