import UIKit

class AimCell: UITableViewCell {
    private let aimTextView = UITextView()
    var saveCellInfo: (_ text: String) -> Void = {text in }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setTapGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAimCell(aim: Aim) {
        aimTextView.text = aim.aimTitle
    }
}

// MARK: - Actions
extension AimCell {
    private func setTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnCell))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func tapOnCell() {
        if aimTextView.isFirstResponder {
            aimTextView.resignFirstResponder()
        } else {
            // В противном случае начинаем редактирование текстового поля
            aimTextView.becomeFirstResponder()
        }
    }
}

// MARK: - UI
extension AimCell {
    private func setUI() {
        // aimTitle
        addSubview(aimTextView)
        aimTextView.font = Resources.Common.futura(size: Resources.Common.Sizes.font16)
        aimTextView.isScrollEnabled = false
        aimTextView.delegate = self
        setAimTitlePosition()
    }
}


// MARK: - Position
extension AimCell {
    private func setAimTitlePosition() {
        aimTextView.translatesAutoresizingMaskIntoConstraints = false 
        [
            aimTextView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            aimTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            aimTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            aimTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ].forEach { $0.isActive = true }
    }
}


// MARK: - TextView
extension AimCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
        
        if let tableView = superview as? UITableView {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        
        saveCellInfo(textView.text)
    }
}
 

