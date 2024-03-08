import UIKit
import Foundation

enum StartPauseResume {
    case start
    case pause
    case resume
}

final class SessionController: BaseController {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startPauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var perkField: UITextField!
    @IBOutlet weak var binButton: UIButton!
    
    var startPauseResume = StartPauseResume.start
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAppearance()
    }
    
    @IBAction func tapStartPauseButton(_ sender: Any) {
        if startPauseResume == .start && perkField.text == "" {
            Resources.SessionController.Animations.highlightTextFieldPlaceholder(textField: perkField)
        }
        else {
            switch startPauseResume {
            case .start:
                startPauseResume = .pause // set pause
                setButton(button: startPauseButton, title: "Pause", backgroundColor: Resources.Common.Colors.purple)
                Resources.SessionController.Animations.changeButtonVisibility(button: stopButton, willHidden: false)
                
                // Start timer
                SessionTimer.startTimer() { [weak self] timeString in
                    self?.timeLabel.text = timeString
                }
            case .pause:
                startPauseResume = .resume // set resume
                setButton(button: startPauseButton, title: "Resume", backgroundColor: Resources.Common.Colors.green)
                
                // Pause timer
                SessionTimer.pauseTimer()
            case .resume:
                startPauseResume = .pause // set pause
                setButton(button: startPauseButton, title: "Pause", backgroundColor: Resources.Common.Colors.purple)
                
                // Resume timer
                SessionTimer.startTimer() { [weak self] timeString in
                    self?.timeLabel.text = timeString
                }
            }
        }
    }
    
    @IBAction func tapStopButton(_ sender: Any) {
        // Saving data
        SessionInfo.perk = perkField.text!
        SessionInfo.time = timeLabel.text!
        print(SessionInfo.perk, SessionInfo.time)

        // Clear screen
        clearAction()
    }
    
    @IBAction func tapBinButton(_ sender: Any) {
        // Clear data
        SessionInfo.clearPerk()
        print(SessionInfo.perk, SessionInfo.time)
        
        // Clear screen
        clearAction()
    }
}

extension SessionController {
    private func setAppearance() {
        Resources.Common.setControllerAppearance(vc: self, title: Resources.TabBar.Titles.session)
        
        // Buttons
        setButton(button: startPauseButton, title: "Start", backgroundColor: Resources.Common.Colors.green)
        
        setButton(button: stopButton, title: "Stop", backgroundColor: Resources.Common.Colors.red)
        stopButton.isHidden = true
        
        setButton(button: binButton, title: "", backgroundColor: Resources.Common.Colors.purple)
        binButton.setImage(Resources.SessionController.Images.bin, for: .normal)

        // Timer
        setLabel()
        
        // Text Field = Perk
        setPerkField()
    }
    
    private func setButton(button: UIButton, title: String, backgroundColor: UIColor) {
        button.backgroundColor = backgroundColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Resources.Common.Sizes.cornerRadius10
        button.titleLabel?.font = Resources.Common.futura(size: 18)
        button.setTitle(title, for: .normal)
    }
    
    private func setLabel() {
        timeLabel.backgroundColor = Resources.Common.Colors.green
        timeLabel.layer.cornerRadius = Resources.Common.Sizes.cornerRadius10
        timeLabel.layer.masksToBounds = true
    }
    
    private func setPerkField() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture))
        view.addGestureRecognizer(tapGesture)
        
        perkField.layer.cornerRadius = Resources.Common.Sizes.cornerRadius10
    }
    
    @objc private func tapGesture() {
        perkField.resignFirstResponder()
    }
    
    private func clearAction() {
        startPauseResume = .start // set start
        setButton(button: startPauseButton, title: "Start", backgroundColor: Resources.Common.Colors.green)
        Resources.SessionController.Animations.changeButtonVisibility(button: stopButton, willHidden: true)
        
        // Stop timer
        SessionTimer.stopTimer()
        timeLabel.text = "00:00:00"
        perkField.text = ""
    }
}



