import UIKit

// MARK: Core
class PerkCell: UITableViewCell {
    var card = UIView()
    var perk = UILabel()
    var lvl = UILabel()
    var toNextLvl = UILabel()
    var progress = UIProgressView()
    var deleteButton = UIButton()
    var deleteButtonHandler: (() -> Void)?
    
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
    }
    
    func enterExitEditMode(editModeWillHidden: Bool) {
        Resources.Common.Animations.changeButtonVisibility(button: deleteButton, willHidden: editModeWillHidden)
    }
    
    @objc func tapDeleteButton() {
        deleteButtonHandler?()
    }

}

// MARK: Appearance
extension PerkCell {
    private func setAppearance() {
        addSubview(card)
        addSubview(perk)
        addSubview(progress)
        addSubview(lvl)
        addSubview(toNextLvl)
        contentView.addSubview(deleteButton)
        
        setCard()
        Resources.Common.setLabel(label: perk, size: Resources.MeController.PerkCell.perkTitleFont, setPosition: setPerkConstraints)
        
        Resources.Common.setLabel(label: lvl, size: Resources.MeController.PerkCell.lvlFont, setPosition: setLvlConstraints)
        
        Resources.Common.setLabel(label: toNextLvl, size: Resources.MeController.PerkCell.lvlFont, setPosition: setToNextLvlConstraints)

        Resources.Common.setButton(button: deleteButton, title: "", image: UIImage(named: "bin"), backgroundColor: Resources.Common.Colors.red, setPosition: setDeleteButtonConstraints)
        deleteButton.addTarget(self, action: #selector(tapDeleteButton), for: .touchUpInside)
        deleteButton.alpha = 0
        
        setProgressLine()
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

// MARK: Constraints
extension PerkCell {
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
            progress.centerYAnchor.constraint(equalTo: centerYAnchor),
            progress.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    private func setLvlConstraints() {
        lvl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lvl.centerXAnchor.constraint(equalTo: centerXAnchor),
            lvl.bottomAnchor.constraint(equalTo: progress.topAnchor, constant: -10)
        ])
    }

    private func setToNextLvlConstraints() {
        toNextLvl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            toNextLvl.centerXAnchor.constraint(equalTo: centerXAnchor),
            toNextLvl.topAnchor.constraint(equalTo: progress.bottomAnchor, constant: 10)
        ])
    }
    
    private func setDeleteButtonConstraints() {
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            deleteButton.widthAnchor.constraint(equalToConstant: 50),
            deleteButton.heightAnchor.constraint(equalToConstant: 50),
            deleteButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            deleteButton.topAnchor.constraint(equalTo: toNextLvl.bottomAnchor, constant: 10)
        ])
    }
}
