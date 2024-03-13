import UIKit
import CoreData

class SessionInfo {
    static var perkTitle: String = ""
    static var time: String = ""
    static var totalSec: Int64 = Int64("\(time[0])\(time[1])")! * 3600 + Int64("\(time[3])\(time[4])")! * 60 + Int64("\(time[6])\(time[7])")!
    // 0 0 : 0 0 : 0 0
    // 0 1 2 3 4 5 6 7

    
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
            let totalSecWithPreviousSession = totalSec + Int64(perk[0].totalHours * 3600)
            
            let (totalSecReturned, lvl, progress, toNextLvl) = calculatePerkDataFromSession(totalSec: totalSecWithPreviousSession)
            let totalHours = Float(totalSecReturned) / 3600.0
            let toNextLvlInHours = Float(toNextLvl) / 3600.0
            
            perk[0].totalHours = Float(String(format: "%.1f", totalHours))!
            perk[0].lvl = lvl
            perk[0].progress = progress
            perk[0].toNextLvl = Float(String(format: "%.1f", toNextLvlInHours))!
            
            Perk.saveContext(context: context)
            print("here")
        } else {
            createNewPerk(context: context, perkTitle: perkTitle, time: totalSec)
            Perk.saveContext(context: context)
        }
        
        // If perk is exists - add info, else - create info
    }
    
    /*
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
        
//        print("total = \(totalHours), progress = \(progress)")

        
        return (Int16(totalHours), Int16(lvl), progress, Int16(toNextLvl))
    }
     */
    
    static func createNewPerk(context: NSManagedObjectContext, perkTitle: String, time: Int64 = 0) {
        let newPerk = Perk(context: context)
       
        let (totalSecReturned, lvl, progress, toNextLvl) = calculatePerkDataFromSession(totalSec: time)
        let totalHours = Float(totalSecReturned) / 3600.0
        let toNextLvlInHours = Float(toNextLvl) / 3600.0
        
        newPerk.perkTitle = perkTitle
        newPerk.totalHours = Float(String(format: "%.1f", totalHours))!
        newPerk.lvl = lvl
        newPerk.progress = progress
        newPerk.toNextLvl = Float(String(format: "%.1f", toNextLvlInHours))!
    }
    
    static func calculatePerkDataFromSession(totalSec: Int64) -> (Int64, Int64, Float, Int64) {
        var lvl: Int64 = 0
        var progress: Float = 0
        var toNextLvl: Int64 = 0
        
        let fiveSiH: Int64 = 5 * 3600
        let tenSiH: Int64 = 10 * 3600
        let fifteenSiH: Int64 = 15 * 3600
        let twentyFiveSiH: Int64 = 25 * 3600
        let thirtySiH: Int64 = 30 * 3600
        let fiftySiH: Int64 = 50 * 3600
        let fiftyFiveSiH: Int64 = 55 * 3600
        
        
        switch totalSec {
        case 0..<fiveSiH: lvl = 0
        case fiveSiH..<fifteenSiH: lvl = 1
        case fifteenSiH..<thirtySiH: lvl = 2
        case thirtySiH..<fiftyFiveSiH: lvl = 3
        default: lvl = Int64((totalSec - fiftyFiveSiH) / fiftySiH) + 4
        }

        switch lvl {
        case 0: toNextLvl = fiveSiH - totalSec
        case 1: toNextLvl = fifteenSiH - totalSec
        case 2: toNextLvl = thirtySiH - totalSec
        case 3: toNextLvl = fiftyFiveSiH - totalSec
        default: toNextLvl = (lvl - 4) * fiftySiH + fiftyFiveSiH + fiftySiH - totalSec
        }

        switch lvl {
        case 0: progress = Float(fiveSiH - toNextLvl) / Float(fiveSiH)
        case 1: progress = Float(tenSiH - toNextLvl) / Float(tenSiH)
        case 2: progress = Float(fifteenSiH - toNextLvl) / Float(fifteenSiH)
        case 3: progress = Float(twentyFiveSiH - toNextLvl) / Float(twentyFiveSiH)
        default: progress = Float(fiftySiH - toNextLvl) / Float(fiftySiH)
        }
        
        return (Int64(totalSec), Int64(lvl), progress, Int64(toNextLvl))
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
