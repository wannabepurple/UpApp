import UIKit

final class MeController: BaseController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var nick: UITextField!
    @IBOutlet weak var plusButton: UIButton!
    
    private var tableView = UITableView()
    private var perks: [Perk] = []
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
        let alert = UIAlertController(title: "Customize perk", message: nil, preferredStyle: .alert)
        alert.addTextField()
        alert.addTextField()
        
        let submitButton = UIAlertAction(title: "Done", style: .default) { (action) in
            let title = alert.textFields![0]
            let seconds = alert.textFields![1]
            
            // Create new perk
            // ADDME: Нулевая строка
            MeModel.createNewPerk(context: self.context, perkTitle: title.text!, time: Int64(seconds.text!)!) // FIXME
            
            // Save data
            Perk.saveContext(context: self.context)
            
            // Refetch data to upd perks
            self.refetchData()
            
            self.tableView.beginUpdates()
            self.tableView.insertSections(IndexSet(integer: self.perks.count - 1), with: .left)
            self.tableView.endUpdates()
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
        
        // Cell Menu
        setCellMenu()
    }
    
    private func setCellMenu() {
        let renameTitle = NSAttributedString(string: "Rename", attributes: [NSAttributedString.Key.font: Resources.Common.futura(size: Resources.Common.Sizes.fon16)])
        let rename = UIAction(title: "", image: UIImage(named: "rename")) { _ in }
        rename.setValue(renameTitle, forKey: "attributedTitle")
        
        let recalculateTitle = NSAttributedString(string: "Recalculate", attributes: [NSAttributedString.Key.font: Resources.Common.futura(size: Resources.Common.Sizes.fon16)])
        let recalculate = UIAction(title: "", image: UIImage(named: "session")) { _ in }
        recalculate.setValue(recalculateTitle, forKey: "attributedTitle")

        let deleteTitle = NSAttributedString(string: "Delete", attributes: [NSAttributedString.Key.font: Resources.Common.futura(size: Resources.Common.Sizes.fon16), NSAttributedString.Key.foregroundColor: Resources.Common.Colors.red])
        let delete = UIAction(title: " ", image: UIImage(named: "bin")?.withTintColor(Resources.Common.Colors.red)) { _ in }
        delete.setValue(deleteTitle, forKey: "attributedTitle")

        cellMenu = UIMenu(title: "", children: [rename, recalculate, delete])
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
}

// MARK: Delegates
extension MeController: UITableViewDelegate, UITableViewDataSource {
    
    // Core
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Cell configuration
        let cell = tableView.dequeueReusableCell(withIdentifier: Resources.MeController.PerkCell.cellIdentifier, for: indexPath) as! PerkCell
        cell.backgroundColor = Resources.Common.Colors.backgroundGray
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
        UIContextMenuConfiguration(actionProvider: { _ in self.cellMenu })
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
        reloadTableView()
    }
}

// MARK: Actions
extension MeController {
    
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
    
    private func deleteCell(section: Int) {
        guard section < self.perks.count else {
            print("error in \(section)")
            return }
        
        // Which perk to remove
        let perkToRemove = self.perks[section]
        
        // Remove the perk
        Perk.deletePerk(context: self.context, perkToRemove: perkToRemove)
        
        // Save the data
        Perk.saveContext(context: self.context)
        
        // Set up the animation
        tableView.beginUpdates()
        
        // Remove the corresponding section
        UIView.animate(withDuration: 0.3) {
            self.tableView.deleteSections(IndexSet(integer: section), with: .automatic)
        }
        
        // Remove the perk from the array
        self.perks.remove(at: section)
        
        // End the animation
        tableView.endUpdates()
        
        // Reload
        let sectionsToUpdate = IndexSet(integersIn: 0..<self.tableView.numberOfSections)
        
        UIView.animate(withDuration: 10) {
            DispatchQueue.main.async {
                self.tableView.reloadSections(sectionsToUpdate, with: .fade)
            }
        }
    }
}

// MARK: Constraints
extension MeController {
    private func setTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
   
}

