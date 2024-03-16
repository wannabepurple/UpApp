import UIKit



// MARK: Core
class PerkCell: UITableViewCell {
    let card = UIView()
    let perk = UILabel()
    let lvl = UILabel()
    let toNextLvl = UILabel()
    let progress = UIProgressView()
    let timerLabel = UILabel()
    let startButton = UIButton()
    let pauseButton = UIButton()
    let stopButton = UIButton()
    
    var cardConstrSmall: [NSLayoutConstraint] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(perkObj: Perk) {
        perk.text = perkObj.perkTitle
        lvl.text = "lvl \(perkObj.lvl)"
        progress.progress = perkObj.progress
        toNextLvl.text = "To next lvl: \(perkObj.toNextLvl) h"
//    ADDME: totalHours
    } // entry point
}

// MARK: Appearance
extension PerkCell {
    private func setAppearance() {
        addSubview(card)
        addSubview(perk)
        addSubview(progress)
        addSubview(lvl)
        addSubview(toNextLvl)
        addSubview(timerLabel)
        addSubview(startButton)
        addSubview(stopButton)
        addSubview(pauseButton)

        setCard()

        setProgressLine()

        Resources.Common.setLabel(label: perk, size: Resources.MeController.PerkCell.perkTitleFont, setPosition: setPerkConstraints)
        
        Resources.Common.setLabel(label: lvl, size: Resources.MeController.PerkCell.lvlFont,  setPosition: setLvlConstraints)
        
        Resources.Common.setLabel(label: toNextLvl, size: Resources.MeController.PerkCell.lvlFont, setPosition: setToNextLvlConstraints)
        
        // timerLabel
        Resources.Common.setLabel(label: timerLabel, size: 30, text: "00:00:00", backgroundColor: Resources.Common.Colors.green, setPosition: setTimerLabelConstraints, masksToBounds: true)
        
        // startStopPauseButton
        Resources.Common.setButton(button: startButton, image: UIImage(named: "start"), backgroundColor: Resources.Common.Colors.green, setPosition: setStartButtonConstraints)
        startButton.addTarget(self, action: #selector(tapStart), for: .touchUpInside)
        
        // pauseButton
        Resources.Common.setButton(button: pauseButton, image: UIImage(named: "pause"), backgroundColor: Resources.Common.Colors.purple, setPosition: setPauseButtonConstraints)
        pauseButton.addTarget(self, action: #selector(tapPause), for: .touchUpInside)
        pauseButton.alpha = 0
        
        // stopButton
        Resources.Common.setButton(button: stopButton, image: UIImage(named: "stop"), backgroundColor: Resources.Common.Colors.red, setPosition: setStopButtonConstraints)
        stopButton.addTarget(self, action: #selector(tapStop), for: .touchUpInside)
        stopButton.alpha = 0
        
       
    }
    
    private func setCard() {
        setCardConstraints()
        card.backgroundColor = Resources.Common.Colors.backgroundCard
        card.layer.cornerRadius = Resources.Common.Sizes.cornerRadius20
    }

    private func setProgressLine() {
        setProgressConstraints()
        progress.layer.cornerRadius = Resources.Common.Sizes.cornerRadius10
        progress.layer.masksToBounds = true
        progress.progressTintColor = Resources.Common.Colors.green
    }
}

// MARK: Actions
extension PerkCell {
    @objc func tapStart() {
        if MeTimer.perkIsActive == false || MeTimer.activePerkTitle == perk.text! {
//            MeTimer.perkIsActive = true
//            MeTimer.activePerkTitle = perk.text!
                        
            
            
            // Start timer
            MeTimer.startTimer() { [weak self] timeString in
                self?.timerLabel.text = timeString
            }
            
            // Change buttons condition
            Resources.Common.Animations.changeButtonVisibility(button: startButton, willHidden: true)
            Resources.Common.Animations.changeButtonVisibility(button: pauseButton, willHidden: false)
            Resources.Common.Animations.changeButtonVisibility(button: stopButton, willHidden: false)
        } else {
            let alertView = UIView()
            alertView.backgroundColor = .white
            alertView.layer.cornerRadius = 10
            alertView.layer.shadowColor = UIColor.black.cgColor
            alertView.layer.shadowOpacity = 0.5
            alertView.layer.shadowOffset = CGSize(width: 0, height: 2)
            
            let imageView = UIImageView(image: UIImage(named: "warning_icon"))
            imageView.contentMode = .scaleAspectFit
            alertView.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 12).isActive = true
            imageView.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
            
            let label = UILabel()
            label.text = "One perk is already in progress."
            label.textColor = .black
            label.textAlignment = .center
            label.numberOfLines = 0
            alertView.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
            label.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 12).isActive = true
            label.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -12).isActive = true
            label.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -12).isActive = true
            
            self.addSubview(alertView)
            alertView.translatesAutoresizingMaskIntoConstraints = false
            alertView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
            alertView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
            alertView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
            alertView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                alertView.transform = CGAffineTransform(translationX: 0, y: -100)
            }) { (_) in
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                        alertView.transform = .identity
                    }, completion: { (_) in
                        alertView.removeFromSuperview()
                    })
                }
            }
        }
    }
    
    @objc func tapPause() {
        // Pause timer
        MeTimer.pauseTimer()
        
        // Change buttons condition
        Resources.Common.Animations.changeButtonVisibility(button: startButton, willHidden: false)
        Resources.Common.Animations.changeButtonVisibility(button: pauseButton, willHidden: true)
    }
    
    @objc func tapStop() {
        // Stop timer
        MeTimer.stopTimer()
        
        // Saving data to model
        MeModel.time = timerLabel.text!
        
        // Clear timer segment
        clearTimerSegment()
        
        print(MeModel.time)
        
    }
    
    private func clearTimerSegment() {
//        MeTimer.perkIsActive = false
//        MeTimer.activePerkTitle = ""
        timerLabel.text = "00:00:00"
        Resources.Common.Animations.changeButtonVisibility(button: startButton, willHidden: false)
        Resources.Common.Animations.changeButtonVisibility(button: pauseButton, willHidden: true)
        Resources.Common.Animations.changeButtonVisibility(button: stopButton, willHidden: true)
    }
}

// MARK: Constraints
extension PerkCell {
    
    private func updateCardConstraints() {
        
    }
    
    private func setCardConstraints() {
        card.translatesAutoresizingMaskIntoConstraints = false
        cardConstrSmall = [
            card.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            card.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            card.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            card.heightAnchor.constraint(equalToConstant: Resources.MeController.PerkCell.cellHeight)
        ]
        NSLayoutConstraint.activate(cardConstrSmall)
    }

    private func setPerkConstraints() {
        perk.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            perk.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            perk.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setProgressConstraints() {
        progress.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progress.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            progress.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            progress.centerXAnchor.constraint(equalTo: centerXAnchor),
            progress.heightAnchor.constraint(equalToConstant: 20),
            progress.topAnchor.constraint(equalTo: lvl.bottomAnchor, constant: 10)
        ])
    }

    private func setLvlConstraints() {
        lvl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lvl.centerXAnchor.constraint(equalTo: centerXAnchor),
            lvl.topAnchor.constraint(equalTo: perk.bottomAnchor, constant: 20)
        ])
    }

    private func setToNextLvlConstraints() {
        toNextLvl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            toNextLvl.centerXAnchor.constraint(equalTo: centerXAnchor),
            toNextLvl.topAnchor.constraint(equalTo: progress.bottomAnchor, constant: 10)
        ])
    }

    private func setTimerLabelConstraints() {
            timerLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                timerLabel.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -20),
                timerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                timerLabel.heightAnchor.constraint(equalToConstant: 50),
                timerLabel.widthAnchor.constraint(equalToConstant: 170)
            ])
    }
    
    private func setStartButtonConstraints() {
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -10),
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setStopButtonConstraints() {
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stopButton.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -10),
            stopButton.leadingAnchor.constraint(equalTo: startButton.trailingAnchor, constant: 10),
            stopButton.widthAnchor.constraint(equalToConstant: 50),
            stopButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setPauseButtonConstraints() {
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pauseButton.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -10),
            pauseButton.trailingAnchor.constraint(equalTo: startButton.leadingAnchor, constant: -10),
            pauseButton.widthAnchor.constraint(equalToConstant: 50),
            pauseButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
