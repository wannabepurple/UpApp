import UIKit

class SessionInfo {
    static var perk: String = ""
    static var time: String = ""
    
    static func clearPerk() {
        SessionInfo.perk = ""
        SessionInfo.time = ""
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


