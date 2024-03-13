import UIKit
import CoreData

class SessionInfo {
    static var perkTitle: String = ""
    static var time: String = ""
    
    static func clearPerk() {
        perkTitle = ""
        time = ""
    }
    
    static func addOrCreatePerk() {
        var perk: [Perk] = []
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // Find match
        Perk.fetchPerkWith(title: perkTitle, perk: &perk, context: context)

        // Perk is exists
        if perk.count == 1 {
            
            print("exists")
            
        } else {
            createNewPerk(context: context, perkTitle: perkTitle, time: SessionInfo.time)
            Perk.saveContext(context: context)
        }
        
        // If perk is exists - add info, else - create info
    }
    
    static func createNewPerk(context: NSManagedObjectContext, perkTitle: String, time: String = "00:00:00") {
        let newPerk = Perk(context: context)
        newPerk.perkTitle = perkTitle
        (newPerk.totalHours,  newPerk.lvl, newPerk.progress, newPerk.toNextLvl) = calculatePerkDataFromSession(time: time)
    }
    
    static func calculatePerkDataFromSession(time: String) -> (Int16, Int16, Float, Int16) {
        // 0 0 : 0 0 : 0 0
        // 0 1 2 3 4 5 6 7
        let totalHours = Int("\(time[0])\(time[1])")!
        var lvl: Int = 0
        var progress: Float = 0
        var toNextLvl: Int = 0
        
        switch totalHours {
        case 0..<5: lvl = 0
        case 5..<15: lvl = 1
        case 15..<30: lvl = 2
        case 30..<55: lvl = 3
        default: lvl = Int((totalHours - 55) / 50) + 4
        }

        switch lvl {
        case 0: toNextLvl = 5 - totalHours
        case 1: toNextLvl = 15 - totalHours
        case 2: toNextLvl = 30 - totalHours
        case 3: toNextLvl = 55 - totalHours
        default: toNextLvl = (lvl - 4) * 50 + 55 + 50 - totalHours
        }
        
        switch lvl {
        case 0: progress = Float(5 - toNextLvl) / Float(5)
        case 1: progress = Float(10 - toNextLvl) / Float(10)
        case 2: progress = Float(15 - toNextLvl) / Float(15)
        case 3: progress = Float(25 - toNextLvl) / Float(25)
        default: progress = Float(50 - toNextLvl) / Float(50)
        }
        print("total = \(totalHours), progress = \(progress)")

        
        return (Int16(totalHours), Int16(lvl), progress, Int16(toNextLvl))
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
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                totalSeconds += 1
                hours = totalSeconds / 3600
                remainingMinutes = (totalSeconds % 3600) / 60
                remainingSeconds = totalSeconds % 60
                
                let timeString = String(format: "%02d:%02d:%02d", hours, remainingMinutes, remainingSeconds)
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
