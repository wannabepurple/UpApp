import UIKit
import CoreData

final class SessionController: BaseController {
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(button)
        button.setTitle("tap", for: .normal)
        button.tintColor = .blue
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        set()
        
    }
    
    @objc func tap() {
        print("tap")
    }
    
    func set() {
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
/*    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startPauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var perkField: UITextField!
    @IBOutlet weak var binButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAppearance()
    }
    
    @IBAction func tapStartPauseButton(_ sender: Any) {
        
    }
    /*
    @IBAction func tapStopButton(_ sender: Any) {
        // Saving data
        SessionInfo.perkTitle = perkField.text!
        SessionInfo.time = timeLabel.text!

        // ADDME: Saving to core data process // entry point
        SessionInfo.addOrCreatePerk()
        
        // Clear data and screen
        SessionInfo.clearPerk()
        clearAction()
    }
    
    @IBAction func tapBinButton(_ sender: Any) {
        // Clear data and screen
        SessionInfo.clearPerk()
        clearAction()
    }
     */
}

extension SessionController {
    private func setAppearance() {        
        // Buttons
        Resources.Common.setButton(button: startPauseButton, title: "Start", image: nil, backgroundColor: Resources.Common.Colors.green)
        
        Resources.Common.setButton(button: stopButton, title: "Stop", image: nil, backgroundColor: Resources.Common.Colors.red)
        stopButton.alpha = 0
        
        Resources.Common.setButton(button: binButton, title: "", image: UIImage(named: "bin"), backgroundColor: Resources.Common.Colors.red)

        // Timer
        Resources.Common.setLabel(label: timeLabel, size: 40, backgroundColor: Resources.Common.Colors.green, masksToBounds: true)
        
        // Text Field = Perk
        setPerkField()
    }
    
    private func setPerkField() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture))
        view.addGestureRecognizer(tapGesture)
        
        perkField.layer.cornerRadius = Resources.Common.Sizes.cornerRadius10
        perkField.textColor = Resources.Common.Colors.backgroundDark
    }
    
    @objc private func tapGesture() {
        perkField.resignFirstResponder()
    }
    
    private func clearAction() {
        startPauseResume = .start // set start
        Resources.Common.setButton(button: startPauseButton, title: "Start", image: nil, backgroundColor: Resources.Common.Colors.green)
        Resources.Common.Animations.changeButtonVisibility(button: stopButton, willHidden: true)
        
        // Stop timer
        SessionTimer.stopTimer()
        timeLabel.text = "00:00:00"
        perkField.text = ""
    }*/
}



