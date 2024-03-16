import UIKit

class SessionView: UIViewController {

    let pauseButton = UIButton()
    let perk = UILabel()
    let timerLabel = UILabel()
    let timerButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        timerProcess()
    }
    
    
    
}

// MARK: UI
extension SessionView {
    private func setUI() {
        view.backgroundColor = Resources.Common.Colors.backgroundCard
        view.addSubview(pauseButton)
        view.addSubview(perk)
        view.addSubview(timerLabel)
        
        Resources.Common.setButton(button: pauseButton, image: UIImage(named: "pause"), backgroundColor: Resources.Common.Colors.purple, setPosition: setPauseButtonConstraints)
        pauseButton.addTarget(self, action: #selector(tapPause), for: .touchUpInside)
        
        Resources.Common.setLabel(label: perk, size: Resources.MeController.SessionView.perkTitleFont, text: MeModel.perkTitle, setPosition: setPerkConstraints)
        
        Resources.Common.setLabel(label: timerLabel, size: Resources.MeController.SessionView.timerLabelFont, text: "00:00:00", backgroundColor: Resources.Common.Colors.green, cornerRadius: Resources.MeController.SessionView.timerCornerRadius, setPosition: setTimerLabelConstraints)
        
    }
}

// MARK: Actions
extension SessionView {
    private func timerProcess() {
        // Start timer
        MeTimer.startTimer() { [weak self] timeString in
            self?.timerLabel.text = timeString
        }
    }
    
    @objc func tapPause() {
        // Pause timer
        MeTimer.pauseTimer()
    }
}


// MARK: Constraints
extension SessionView {
    private func setPerkConstraints() {
        perk.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            perk.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            perk.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setPauseButtonConstraints() {
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pauseButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            pauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pauseButton.widthAnchor.constraint(equalToConstant: 50),
            pauseButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    private func setTimerLabelConstraints() {
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            timerLabel.widthAnchor.constraint(equalToConstant: Resources.MeController.SessionView.timerSide),
            timerLabel.heightAnchor.constraint(equalToConstant: Resources.MeController.SessionView.timerSide)
        ])
    }
    
}
