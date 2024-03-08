import UIKit

class MeController: BaseController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nick: UITextField!
    
    var perks: [String] = ["First"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAppearance()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PerkCard")
        tableView.dataSource = self
    }

}

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
//        avatar.backgroundColor = Resources.Common.Colors.backgroundWhite
//        avatar.layer.cornerRadius = avatar.bounds.width / 2
        
    }
    
    private func setTableView() {
        tableView.backgroundColor = Resources.Common.Colors.backgroundGray
    }
}

extension MeController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "PerkCard") {
            cell = reuseCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "PerkCard")
        }
        configureCell(cell: &cell, indexPath: indexPath)
        return cell
    }
    
    private func configureCell(cell: inout UITableViewCell, indexPath: IndexPath) {
        var config = cell.defaultContentConfiguration()
        config.text = "hello"
        config.secondaryText = "world"
        cell.contentConfiguration = config
    }
    
    
}

