import UIKit
import CoreData

class MeModel {
    static var perkTitle: String = ""
    static var time: String = ""
    
    // 0 0 : 0 0 : 0 0
    // 0 1 2 3 4 5 6 7
    static var totalSecFromSession: Int64 = Int64("\(time[0])\(time[1])")! * 3600 + Int64("\(time[3])\(time[4])")! * 60 + Int64("\(time[6])\(time[7])")!
    
    static func createNewPerk(context: NSManagedObjectContext, perkTitle: String, time: Int64 = 0) {
        
        let newPerk = Perk(context: context)
        
        newPerk.perkTitle = perkTitle
        newPerk.totalHours = 0.0
        newPerk.lvl = 0
        newPerk.progress = 0.0
        newPerk.toNextLvl = 5.0
        newPerk.totalSeconds = 0
        
        Perk.saveContext(context: context)

    }
    
    static func calculateAndSaveDataFromSession() {
        var perk: [Perk] = []
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        Perk.fetchPerkWith(title: perkTitle, perk: &perk, context: context)
        perk[0].totalSeconds += totalSecFromSession // update totalSeconds from all previous sessions in this perk
        
        let (totalSecReturned, lvl, progress, toNextLvl) = calculateDataFromSession(totalSeconds: perk[0].totalSeconds)
        let totalHours = Float(totalSecReturned) / 3600.0
        let toNextLvlInHours = Float(toNextLvl) / 3600.0
        
        perk[0].perkTitle = perkTitle
        perk[0].totalHours = Float(String(format: "%.1f", totalHours))!
        perk[0].lvl = lvl
        perk[0].progress = progress
        perk[0].toNextLvl = Float(String(format: "%.1f", toNextLvlInHours))!
        
        Perk.saveContext(context: context)
    }
    
    static func clearMeModel() {
        perkTitle = ""
        time = ""
        totalSecFromSession = 0
    }
    
    static func calculateDataFromSession(totalSeconds: Int64) -> (Int64, Int64, Float, Int64) {
        var lvl: Int64 = 0
        var progress: Float = 0.0
        var toNextLvl: Int64 = 0
        
        let fiveSiH: Int64 = 5 * 3600
        let tenSiH: Int64 = 10 * 3600
        let fifteenSiH: Int64 = 15 * 3600
        let twentyFiveSiH: Int64 = 25 * 3600
        let thirtySiH: Int64 = 30 * 3600
        let fiftySiH: Int64 = 50 * 3600
        let fiftyFiveSiH: Int64 = 55 * 3600
        
        switch totalSeconds {
        case 0..<fiveSiH: lvl = 0
        case fiveSiH..<fifteenSiH: lvl = 1
        case fifteenSiH..<thirtySiH: lvl = 2
        case thirtySiH..<fiftyFiveSiH: lvl = 3
        default: lvl = Int64((totalSeconds - fiftyFiveSiH) / fiftySiH) + 4
        }
        
        switch lvl {
        case 0: toNextLvl = fiveSiH - totalSeconds
        case 1: toNextLvl = fifteenSiH - totalSeconds
        case 2: toNextLvl = thirtySiH - totalSeconds
        case 3: toNextLvl = fiftyFiveSiH - totalSeconds
        default: toNextLvl = (lvl - 4) * fiftySiH + fiftyFiveSiH + fiftySiH - totalSeconds
        }
        
        switch lvl {
        case 0: progress = Float(fiveSiH - toNextLvl) / Float(fiveSiH)
        case 1: progress = Float(tenSiH - toNextLvl) / Float(tenSiH)
        case 2: progress = Float(fifteenSiH - toNextLvl) / Float(fifteenSiH)
        case 3: progress = Float(twentyFiveSiH - toNextLvl) / Float(twentyFiveSiH)
        default: progress = Float(fiftySiH - toNextLvl) / Float(fiftySiH)
        }
        
        return (Int64(totalSeconds), Int64(lvl), progress, Int64(toNextLvl))
    }
}

class MeTimer {
    static var wasPaused = false
    static var totalSeconds = 0
    static var timer: Timer?
    static var hours = 0
    static var remainingMinutes = 0
    static var remainingSeconds = 0
    
    
    static func startTimer(updateClosure: @escaping (String) -> Void) {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                totalSeconds += 1
                hours = 1 + totalSeconds / 3600
                remainingMinutes = (totalSeconds % 3600) / 60
                remainingSeconds = totalSeconds % 60
                
                let timeString = String(format: "%02d:%02d:%02d", hours, remainingMinutes, remainingSeconds)
                DispatchQueue.main.async {
                    updateClosure(timeString)
                }
            }
        }
    }
    
    static func pauseTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    static func stopTimer() {
        pauseTimer()
        totalSeconds = 0
        hours = 0
        remainingMinutes = 0
        remainingSeconds = 0
    }
    
}
