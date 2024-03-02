import UIKit
import Foundation

class SessionController: BaseController {
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startPauseButton: UIButton!
    @IBOutlet weak var targetField: UITextField!
    
    // [ start = 0, pause = 1, resume = 2 ]
    var startPauseResume = 0
    var timer: Timer?
    var totalSeconds = 0
    
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAppearance()
    }
    
    @IBAction func tapStartPauseButton(_ sender: Any) {
        // ADDME - start the timer
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                self.totalSeconds += 1
                let hours = self.totalSeconds / 3600
                let remainingMinutes = (self.totalSeconds % 3600) / 60
                let remainingSeconds = self.totalSeconds % 60
 
                self.timeLabel.text = String(format: "%02d:%02d:%02d", hours, remainingMinutes, remainingSeconds)
            })
        } else {
            timer?.invalidate()
            timer = nil
        }
    
        
        switch startPauseResume {
        case 0:
            startPauseResume = 1 // set pause
            setButtonAppearance(button: startPauseButton, title: "Pause", backgroundColor: Resources.Common.Colors.yellow)
            Resources.SessionController.Animations.changeButtonVisibility(button: stopButton, willHidden: false)
        case 1:
            startPauseResume = 2 // set resume
            setButtonAppearance(button: startPauseButton, title: "Resume", backgroundColor: Resources.Common.Colors.green)
        case 2:
            startPauseResume = 1 // set pause
            setButtonAppearance(button: startPauseButton, title: "Pause", backgroundColor: Resources.Common.Colors.yellow)
        default: break
        }
    }
    
    @IBAction func tapStopButton(_ sender: Any) {
        startPauseResume = 0 // set start
        setButtonAppearance(button: startPauseButton, title: "Start", backgroundColor: Resources.Common.Colors.green)
        Resources.SessionController.Animations.changeButtonVisibility(button: stopButton, willHidden: true)
    }
    
}


extension SessionController {
    private func setAppearance() {
        Resources.Common.setControllerAppearance(vc: self, title: Resources.TabBar.Titles.session)
        
        // Buttons
        setButtonAppearance(button: startPauseButton, title: "Start", backgroundColor: Resources.Common.Colors.green)
        setButtonAppearance(button: stopButton, title: "Stop", backgroundColor: Resources.Common.Colors.red)
        stopButton.isHidden = true
        
        // Timer        
        timeLabel.backgroundColor = Resources.Common.Colors.green
        timeLabel.layer.cornerRadius = Resources.SessionController.Sizes.cornerRadius
        timeLabel.layer.masksToBounds = true
    }
    
    private func setButtonAppearance(button: UIButton, title: String, backgroundColor: UIColor) {
        button.backgroundColor = backgroundColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Resources.SessionController.Sizes.cornerRadius
        button.titleLabel?.font = Resources.Common.futura(size: 18)
        button.setTitle(title, for: .normal)
    }
}



