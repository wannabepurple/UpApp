import UIKit

final class MeController: BaseController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var nick: UITextField!
    var tableView = UITableView()
    
    var perks: [String] = ["First"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAppearance()
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
//        avatar.backgroundColor = Resources.Common.Colors.backgroundWhite
//        avatar.layer.cornerRadius = avatar.bounds.width / 2
        
        // Nick
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    @objc private func tapGesture() {
        nick.resignFirstResponder()
    }
    
    private func setTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 100
        // set register cell
        setTableViewConstraints()
        
        tableView.layer.cornerRadius = Resources.Common.Sizes.cornerRadius20
    }

    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: Delegates
extension MeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
     
}

// MARK: Contraints
extension MeController {
    private func setTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
    }
}
