import UIKit

class EditMode {
    static var editModeWillHidden: Bool = true
    
    static func switchEditMode() {
        if editModeWillHidden == true {
            editModeWillHidden = false
        } else {
            editModeWillHidden = true
        }
    }
}
