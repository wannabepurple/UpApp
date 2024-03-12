import UIKit

// MARK: Core
class PerkCell: UITableViewCell {
    var card = UIView()
    var perk = UILabel()
    var lvl = UILabel()
    var toNextLvl = UILabel()
    var progress = UIProgressView()
    var deleteButton = UIButton()
    
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
    
    //
    func addDeleteButton() {
           // Customize this method to add the delete button to your cell
           let deleteButton = UIButton(type: .system)
           deleteButton.setTitle("Delete", for: .normal)
           deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)

        deleteButton.translatesAutoresizingMaskIntoConstraints = false

           // Add the delete button to the cell's content view
           contentView.addSubview(deleteButton)
       }

       @objc private func deleteButtonTapped() {
           // Handle delete button tap if needed
           print("del")
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
        
        setCard()
        Resources.Common.setLabel(label: perk, size: Resources.MeController.PerkCell.perkTitleFont, setPosition: setPerkConstraints)
        Resources.Common.setLabel(label: lvl, size: Resources.MeController.PerkCell.lvlFont, setPosition: setLvlConstraints)
        Resources.Common.setLabel(label: toNextLvl, size: Resources.MeController.PerkCell.lvlFont, setPosition: setToNextLvlConstraints)
        Resources.Common.setButton(button: deleteButton, title: "", image: UIImage(named: "trash"), backgroundColor: Resources.Common.Colors.red/*, setPosition: setDeleteButtonConstraints*/)
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
}
