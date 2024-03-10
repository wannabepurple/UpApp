import UIKit

// MARK: Core
class PerkCell: UITableViewCell {
    var card = UIView()
    var perk = UILabel()
    var lvl = UILabel()
    var toNextLvl = UILabel()
    var progress = UIProgressView()
    var separator = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func set(perkObj: Perk) {
        perk.text = perkObj.perkTitle
    }

}

// MARK: Appearance
extension PerkCell {
    private func setAppearance() {
        addSubview(card)
        addSubview(perk)
        addSubview(lvl)
        addSubview(toNextLvl)
        addSubview(progress)
        
        setCard()
//        setPerk()
    }
    
    private func setCard() {
        setCardConstraints()
        card.backgroundColor = Resources.Common.Colors.backgroundCard
        card.layer.cornerRadius = Resources.Common.Sizes.cornerRadius20
    }
    
    private func setPerk() {
        setPerkConstraints()
        perk.text = "Perk"
        perk.adjustsFontSizeToFitWidth = true
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
            card.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func setPerkConstraints() {
        perk.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            perk.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            perk.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

