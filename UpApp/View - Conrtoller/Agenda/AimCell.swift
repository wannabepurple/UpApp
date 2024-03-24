import UIKit

class AimCell: UITableViewCell {
    let aimTextView = UITextView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAimCell(aim: Aim) {
        aimTextView.text = aim.aimTitle
    }
}



// MARK: - UI
extension AimCell {
    private func setUI() {
        // aimTitle
        addSubview(aimTextView)
        aimTextView.font = Resources.Common.futura(size: Resources.Common.Sizes.font16)
        aimTextView.textAlignment = .natural
        aimTextView.isScrollEnabled = false
        aimTextView.isEditable = true
        aimTextView.delegate = self
        
        setAimTitlePosition()
    }
}


// MARK: - Position
extension AimCell {
    private func setAimTitlePosition() {
        aimTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            aimTextView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            aimTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            aimTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            aimTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
    
}


// MARK: - TextView
extension AimCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updateTextViewHeight()
    }
    
    private func updateTextViewHeight() {
        let fixedWidth = aimTextView.frame.size.width
        let newSize = aimTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        aimTextView.constraints.forEach {
            if $0.firstAttribute == .height {
                $0.constant = newSize.height
            }
        }
        self.layoutIfNeeded()
    }
}

