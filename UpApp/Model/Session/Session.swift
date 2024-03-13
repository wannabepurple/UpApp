import UIKit
import CoreData

class SessionInfo {
    static var perkTitle: String = ""
    static var time: String = ""
    
    static func clearPerk() {
        perkTitle = ""
        time = ""
    }
    
    static func calculatePerkDataFromSession() {
        var perk: [Perk] = []
        var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        Perk.fetchPerkWith(title: perkTitle, perk: &perk, context: context)

        // Perk is exists
        if perk.count == 1 {
            
            print("exists")
            
        } else {
            let newPerk = createNewPerk(context: context, perkTitle: perkTitle, time: SessionInfo.time)
            Perk.saveContext(context: context)
        }
        
        // If perk is exists - add info, else - create info
    }
    
    static func createNewPerk(context: NSManagedObjectContext, perkTitle: String) -> Perk {
        let newPerk = Perk(context: context)
        newPerk.lvl = 0
        newPerk.perkTitle = perkTitle
        newPerk.progress = 0
        newPerk.toNextLvl = 10
        return newPerk
    }
}

class SessionTimer {
    static var totalSeconds = 0
    static var timer: Timer?
    static var hours = 0
    static var remainingMinutes = 0
    static var remainingSeconds = 0
    
    static func startTimer(updateClosure: @escaping (String) -> Void) {
        if timer == nil {
            SessionTimer.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                SessionTimer.totalSeconds += 1
                SessionTimer.hours = SessionTimer.totalSeconds / 3600
                SessionTimer.remainingMinutes = (SessionTimer.totalSeconds % 3600) / 60
                SessionTimer.remainingSeconds = SessionTimer.totalSeconds % 60
                
                let timeString = String(format: "%02d:%02d:%02d", SessionTimer.hours, SessionTimer.remainingMinutes, SessionTimer.remainingSeconds)
                updateClosure(timeString)
            }
        }
    }
    
    static func pauseTimer() {
        SessionTimer.timer?.invalidate()
        SessionTimer.timer = nil
    }
    
    static func stopTimer() {
        SessionTimer.pauseTimer()
        SessionTimer.totalSeconds = 0
        SessionTimer.hours = 0
        SessionTimer.remainingMinutes = 0
        SessionTimer.remainingSeconds = 0
    }
}
