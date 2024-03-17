import UIKit

// MARK: Core
class PerkCell: UITableViewCell {
    let card = UIView()
    let perk = UILabel()
    let lvl = UILabel()
    let toNextLvl = UILabel()
    let totalHours = UILabel()
    let progress = UIProgressView()
    let startButton = UIButton()
    var openSessionView: (() -> Void)?
    
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
        toNextLvl.text = "To next lvl <-> \(perkObj.toNextLvl) h"
        totalHours.text = "Total hours <-> \(perkObj.totalHours)"
    } // entry point
}

// MARK: UI
extension PerkCell {
    private func setAppearance() {
        addSubview(card)
        addSubview(perk)
        addSubview(progress)
        addSubview(lvl)
        addSubview(toNextLvl)
        addSubview(startButton)
        addSubview(totalHours)

        // cardView
        setCard()

        // progressLine
        setProgressLine()

        // perkTitle
        Resources.Common.setLabel(label: perk, size: Resources.MeController.PerkCell.perkTitleFont, setPosition: setPerkConstraints)
        
        // lvlLabel
        Resources.Common.setLabel(label: lvl, size: Resources.MeController.PerkCell.lvlFont,  setPosition: setLvlConstraints)
        
        // toNextLvlLable
        Resources.Common.setLabel(label: toNextLvl, size: Resources.MeController.PerkCell.lvlFont, setPosition: setToNextLvlConstraints)
        
        // totalHours
        Resources.Common.setLabel(label: totalHours, size: Resources.Common.Sizes.font20, setPosition: setTotalHoursConstraints)
        
        // startButton
        Resources.Common.setButton(button: startButton, image: UIImage(named: "start"), backgroundColor: Resources.Common.Colors.green, setPosition: setStartButtonConstraints)
        startButton.addTarget(self, action: #selector(tapStart), for: .touchUpInside)
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
        MeModel.perkTitle = perk.text!
        openSessionView?()
    }
}

// MARK: Constraints
extension PerkCell {
    private func setTotalHoursConstraints() {
        totalHours.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            totalHours.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -20),
            totalHours.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setCardConstraints() {
        card.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            card.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            card.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            card.heightAnchor.constraint(equalToConstant: Resources.MeController.PerkCell.cellHeight)
        ])
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

    /*
    private func setTimerLabelConstraints() {
            timerLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                timerLabel.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -20),
                timerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                timerLabel.heightAnchor.constraint(equalToConstant: 50),
                timerLabel.widthAnchor.constraint(equalToConstant: 170)
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
     
    
     
     
    */
    private func setStartButtonConstraints() {
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -10),
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
}







