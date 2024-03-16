import UIKit
import CoreData

protocol ModalViewControllerDelegate: AnyObject {
    func didDismissModalViewController()
}

// MARK: Core
class SessionView: UIViewController {
    weak var delegate: ModalViewControllerDelegate?
    let pauseButton = UIButton()
    let perk = UILabel()
    let timerLabel = UILabel()
    let timerButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        timerProcess()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Stop timer
        MeTimer.stopTimer()
        MeModel.calculateAndSaveDataFromSession()
        
        if isBeingDismissed {
            delegate?.didDismissModalViewController()
        }
    }
}

// MARK: UI
extension SessionView {
    private func setUI() {
        view.backgroundColor = Resources.Common.Colors.backgroundCard
        view.addSubview(perk)
        view.addSubview(timerButton)
        
        Resources.Common.setLabel(label: perk, size: Resources.MeController.SessionView.perkTitleFont, text: MeModel.perkTitle, setPosition: setPerkConstraints)
        
        Resources.Common.setButton(button: timerButton, 
                                   size: Resources.MeController.SessionView.timerButtonFont,
                                   title: "00:00:00",
                                   image: nil,
                                   backgroundColor: Resources.Common.Colors.green,
                                   cornerRadius: Resources.MeController.SessionView.timerCornerRadius,
                                   setPosition: setTimerButtonConstraints)
        timerButton.addTarget(self, action: #selector(tapTimer), for: .touchUpInside)
    }
}

// MARK: Actions
extension SessionView {
    
    private func timerProcess() {
        // Start timer
        MeTimer.startTimer() { [weak self] timeString in
            self?.timerButton.setTitle(timeString, for: .normal)
            MeModel.time = timeString
        }
    }
    
    
    @objc func tapTimer() {
        if MeTimer.wasPaused == false {
            MeTimer.wasPaused = true
            MeTimer.pauseTimer()
            timerButton.setImage(UIImage(named: "pause"), for: .normal)
        } else {
            MeTimer.wasPaused = false
            MeTimer.startTimer() { [weak self] timeString in
                self?.timerButton.setTitle(timeString, for: .normal)
                MeModel.time = timeString
            }
            timerButton.setImage(nil, for: .normal)
        }
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
    
    private func setTimerButtonConstraints() {
        timerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            timerButton.widthAnchor.constraint(equalToConstant: Resources.MeController.SessionView.timerSide),
            timerButton.heightAnchor.constraint(equalToConstant: Resources.MeController.SessionView.timerSide)
        ])
    }
}
