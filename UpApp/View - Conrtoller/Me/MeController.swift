import UIKit

final class MeController: BaseController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var nick: UITextField!
    @IBOutlet weak var plusButton: UIButton!
    var tableView = UITableView()
    
    var perks: [Perk] = []
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAppearance()
        fetchPerks()
    }
    
    // Fetch the data from Core Data to display on the tableView
    private func fetchPerks() {
        do {
            self.perks = try context.fetch(Perk.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            print(perks)
        } catch { }
    }
    
    @IBAction func tapPlus(_ sender: Any) {
        let alert = UIAlertController(title: "Customize perk", message: nil, preferredStyle: .alert)
        alert.addTextField()
        
        let submitButton = UIAlertAction(title: "Done", style: .default) { (action) in
            let textField = alert.textFields![0]
            
            // Create perk obj
            let newPerk = Perk(context: self.context)
            newPerk.lvl = 0
            newPerk.perkTitle = textField.text
            newPerk.progress = 0
            newPerk.toNextLvl = 10
            
            // Save the data
            do { try self.context.save() } catch { }
            
            // Re-fetch the data
            self.fetchPerks()
        }
        
        // Add Done button
        alert.addAction(submitButton)
        
        // Show alert
        self.present(alert, animated: true)
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
        topView.backgroundColor = Resources.Common.Colors.backgroundCard
        topView.layer.cornerRadius = Resources.Common.Sizes.cornerRadius20
        
        plusButton.layer.cornerRadius = Resources.Common.Sizes.cornerRadius10
        plusButton.backgroundColor = Resources.Common.Colors.green
    
        
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return perks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Resources.MeController.PerkCell.cellIdentifier, for: indexPath) as! PerkCell
        
        let perk = perks[indexPath.row]
        cell.set(perkObj: perk)
        cell.backgroundColor = Resources.Common.Colors.backgroundGray
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 220
       }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Create swipe action
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler)  in
            
            // Which perk to remove
            let perkToRemove = self.perks[indexPath.row]
            
            // Remove the perk
            self.context.delete(perkToRemove)
            
            // Save the data
            do { try self.context.save() } catch { }
            
            // Re-fetch the data
            self.fetchPerks()
        }
        
        // Return swipe actions
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Rename") { (action, view, completionHandler)  in
            
            // Which perk to rename
            let perkToRemove = self.perks[indexPath.row]
            
            // Rename the perk
            self.perks[indexPath.row].perkTitle = "Renamed"
            
            // Save the data
            do { try self.context.save() } catch { }
            
            // Re-fetch the data
            self.fetchPerks()
        }
        
        // Return swipe actions
        return UISwipeActionsConfiguration(actions: [action])
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
