import UIKit

final class MeController: BaseController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var nick: UITextField!
    @IBOutlet weak var plusButton: UIButton!

    private let incorrectDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
    private var tableView = UITableView()
    private var perks: [Perk] = [] {
        didSet {
            reloadTableView()
        }
    }
    private var cellMenu = UIMenu()
    private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refetchData()
        reloadTableView()
    }
    
    /// Refactor
    @IBAction func tapPlus(_ sender: Any) {
        let alert = UIAlertController(title: "Customize your perk", message: nil, preferredStyle: .alert)
        alert.addTextField()
        alert.addTextField()
        alert.textFields![0].placeholder = "Name of the perk (ex: Perk)"
        alert.textFields![1].placeholder = "Hours, spent on this perk (ex: 45.3)"

        
        let submitButton = UIAlertAction(title: "Done", style: .default) { (action) in
            let perkTitleTextField = alert.textFields![0]
            let totalHoursTextField = alert.textFields![1]
            
            // Create new perk
            var incorrectDataFlag = false
            if perkTitleTextField.text != "" && totalHoursTextField.text != "" {
                var checkPerk: [Perk] = []
                Perk.fetchPerkWith(title: perkTitleTextField.text!, perk: &checkPerk, context: self.context)
                
                if checkPerk.count > 0 {
                    incorrectDataFlag = true
                } else if let hours = Float(totalHoursTextField.text!) {
                    if hours > 10100 {
                        print("Too many hours")
                    } else {
                        let totalSecondsFromTextField = Int64(hours * 3600)
                        
                        MeModel.createNewPerk(context: self.context, perkTitle: perkTitleTextField.text!, time: totalSecondsFromTextField)
                        self.refetchData()
                    }
                } else {
                    incorrectDataFlag = true
                }
            } else {
                incorrectDataFlag = true
            }
            
            if incorrectDataFlag {
                self.setWarningLabel()
                
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.incorrectDataLabel.alpha = 1
                }) { _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        UIView.animate(withDuration: 0.5) {
                            self.incorrectDataLabel.alpha = 0
                        }
                    }
                }

            }
        }
        
        // Add Done button
        alert.addAction(submitButton)
        
        // Show alert
        self.present(alert, animated: true)
    }
}

// MARK: UI
extension MeController {
    
    private func setAppearance() {
        // Avatar
        setTopView()
        
        // Table View
        setTableView()
    }
    
    private func setTopView() {
        Resources.Common.setButton(button: plusButton, image: nil, backgroundColor: Resources.Common.Colors.green)

        // Nick
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func tapGesture() {
        nick.resignFirstResponder()
    }
    
    private func setTableView() {
        // Required
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.register(PerkCell.self, forCellReuseIdentifier: Resources.MeController.PerkCell.cellIdentifier)
        setTableViewConstraints()
        
        // Opt
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = Resources.Common.Sizes.cornerRadius20
        tableView.backgroundColor = Resources.Common.Colors.backgroundGray
        tableView.showsVerticalScrollIndicator = false
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setWarningLabel() {
        incorrectDataLabel.textAlignment = .center
        incorrectDataLabel.backgroundColor = Resources.Common.Colors.purple
        incorrectDataLabel.text = "Incorrect data or perk duplicate"
        incorrectDataLabel.layer.masksToBounds = true
        incorrectDataLabel.layer.cornerRadius = Resources.Common.Sizes.cornerRadius20
        incorrectDataLabel.numberOfLines = 2
        incorrectDataLabel.font = Resources.Common.futura(size: Resources.Common.Sizes.font16)
        incorrectDataLabel.textColor = Resources.Common.Colors.backgroundCard
        incorrectDataLabel.alpha = 0
        incorrectDataLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(incorrectDataLabel)

        NSLayoutConstraint.activate([
            incorrectDataLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            incorrectDataLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            incorrectDataLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            incorrectDataLabel.heightAnchor.constraint(equalToConstant: 50)])
    }
    

}

// MARK: Delegates
extension MeController: UITableViewDelegate, UITableViewDataSource {
    
    // Core
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Cell configuration
        let cell = tableView.dequeueReusableCell(withIdentifier: Resources.MeController.PerkCell.cellIdentifier, for: indexPath) as! PerkCell
        cell.backgroundColor = Resources.Common.Colors.backgroundCard
        cell.selectionStyle = .none
        cell.contentView.isUserInteractionEnabled = false
        cell.layer.cornerRadius = Resources.Common.Sizes.cornerRadius20
        
        cell.openSessionView = {
            let sessionView = SessionView()
            sessionView.delegate = self
            sessionView.modalPresentationStyle = .automatic
            self.present(sessionView, animated: true)
        }
            
        // Labels, progress
        let perk = perks[indexPath.section]
        cell.set(perkObj: perk) // entry point
        return cell
    }
     
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        setCellMenu(indexPath: indexPath)
        return UIContextMenuConfiguration(actionProvider: { _ in self.cellMenu })
    }
    
    // Sup
    func numberOfSections(in tableView: UITableView) -> Int {
        return perks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Resources.MeController.PerkCell.cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return Resources.MeController.PerkCell.cellFootHeight
    }
}

extension MeController: ModalViewControllerDelegate {
    // Method starts when modal view did dissapear
    func didDismissModalViewController() {
        refetchData()
    }
}

// MARK: Actions
extension MeController {
    private func setCellMenu(indexPath: IndexPath) {
        
        // Rename
        let renameTitle = Resources.Common.returnStringWithAttributes(title: "Rename")
        let rename = UIAction(title: "", image: UIImage(named: "rename")) { _ in
            let alertTitle = Resources.Common.returnStringWithAttributes(title: "Type a new perk title")
            let alert = UIAlertController(title: "", message: nil, preferredStyle: .alert)
            alert.setValue(alertTitle, forKey: "attributedTitle")
            alert.addTextField()
            
            let submitButton = UIAlertAction(title: "Done", style: .default) { (action) in
                let text = alert.textFields?[0].text!
                if text != "" {
                    self.perks[indexPath.section].perkTitle = text
                    Perk.saveContext(context: self.context)
                    Perk.fetchPerks(perks: &self.perks, context: self.context)
                } else {
                    print("Empty text field")
                }
            }
            
            alert.addAction(submitButton)
            self.present(alert, animated: true)
        }
        rename.setValue(renameTitle, forKey: "attributedTitle")
        
        
        // Recalculate
        let recalculateTitle = Resources.Common.returnStringWithAttributes(title: "Recalculation")
        let recalculate = UIAction(title: "", image: UIImage(named: "session")) { _ in
            let alertTitle = Resources.Common.returnStringWithAttributes(title: "Type the total hours")
            let alert = UIAlertController(title: "", message: nil, preferredStyle: .alert)
            alert.setValue(alertTitle, forKey: "attributedTitle")
            alert.addTextField()

            let submitButton = UIAlertAction(title: "Done", style: .default) { (action) in
                if let text = Int64(alert.textFields![0].text!) {
                    self.perks[indexPath.section].perkTitle = String(text)
                    Perk.saveContext(context: self.context)
                    Perk.fetchPerks(perks: &self.perks, context: self.context)
                } else {
                    print("Not time")
                }
            }
            
            alert.addAction(submitButton)
            self.present(alert, animated: true)
        }
        recalculate.setValue(recalculateTitle, forKey: "attributedTitle")

        
        // Delete
        let deleteTitle = Resources.Common.returnStringWithAttributes(title: "Delete", color: Resources.Common.Colors.red)
        let delete = UIAction(title: " ", image: UIImage(named: "bin")?.withTintColor(Resources.Common.Colors.red)) { _ in
            Perk.deletePerk(context: self.context, perkToRemove: self.perks[indexPath.section])
            Perk.saveContext(context: self.context)
            self.refetchData()
            
        }
        delete.setValue(deleteTitle, forKey: "attributedTitle")
        
        cellMenu = UIMenu(title: "", children: [rename, recalculate, delete])
    }
}

// MARK: Support
extension MeController {
    private func refetchData() {
        Perk.fetchPerks(perks: &perks, context: context)
    }

    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
     

// MARK: Constraints
extension MeController {
    private func setTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}
