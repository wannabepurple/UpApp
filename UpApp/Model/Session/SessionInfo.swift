import UIKit

class SessionInfo {
    static var perk: String = ""
    static var time: String = ""
    
    static func clearPerk() {
        SessionInfo.perk = ""
        SessionInfo.time = ""
    }
}
