import UIKit

final class MeController: BaseController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var nick: UITextField!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    var tableView = UITableView()
    
    var perks: [Perk] = []
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAppearance()
        reloadData()
    }
    
    private func reloadData() {
        Perk.fetchPerks(perks: &perks, context: context)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    

    @IBAction func tapPlus(_ sender: Any) {
        let alert = UIAlertController(title: "Customize perk", message: nil, preferredStyle: .alert)
        alert.addTextField()
        
        let submitButton = UIAlertAction(title: "Done", style: .default) { (action) in
            let textField = alert.textFields![0]
            
            // Create new perk obj
            let newPerk = Perk(context: self.context)
            newPerk.lvl = 0
            newPerk.perkTitle = textField.text
            newPerk.progress = 0
            newPerk.toNextLvl = 10
            
            // Save data
            Perk.saveContext(context: self.context)
            
            // Reload data
            self.reloadData() 
        }
        
        // Add Done button
        alert.addAction(submitButton)
        
        // Show alert
        self.present(alert, animated: true)
    }
    
    @IBAction func tapEdit(_ sender: Any) {
        print("heeror")
    }
}

// MARK: Setup
extension MeController {
    private func setAppearance() {
        Resources.Common.setControllerAppearance(vc: self, title: Resources.TabBar.Titles.me)
        
        // Avatar
        setTopView()
        
        // Table View
        setTableView()
    }
    
    private func setTopView() {
        Resources.Common.setButton(button: plusButton, title: "", backgroundColor: Resources.Common.Colors.green)
            
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return perks.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Resources.MeController.PerkCell.cellIdentifier, for: indexPath) as! PerkCell
        
        let perk = perks[indexPath.section]
        cell.set(perkObj: perk)
        cell.backgroundColor = Resources.Common.Colors.backgroundGray
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Resources.MeController.PerkCell.cellHeight
       }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Create swipe action
        let action = UIContextualAction(style: .normal, title: "Delete") { (_, _, _)  in
            
            // Which perk to remove
            let perkToRemove = self.perks[indexPath.section]
            
            // Remove the perk
            Perk.deletePerk(context: self.context, perkToRemove: perkToRemove)
            
            // Save the data
            Perk.saveContext(context: self.context)
            
            // Re-fetch the data
            self.reloadData()
        }
        
        action.backgroundColor = Resources.Common.Colors.purple
        
        
        // Return swipe actions
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Rename") { (action, view, completionHandler)  in
            
            // Rename the perk
            self.perks[indexPath.section].perkTitle = "Renamed"
            
            // Save the data
            Perk.saveContext(context: self.context)
            
            // Re-fetch the data
            self.reloadData()
        }
        
        // Return swipe actions
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return Resources.MeController.PerkCell.cellFootHeight
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


///
    
    
    
    
    
    
   

