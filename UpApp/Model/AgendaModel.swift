import UIKit
import CoreData

class AgendaModel {
    static func createNewAim(context: NSManagedObjectContext, aimTitle: String) {
        let newAim = Aim(context: context)
        
        newAim.aimTitle = aimTitle
        
        Aim.saveContext(context: context)
    }
}
