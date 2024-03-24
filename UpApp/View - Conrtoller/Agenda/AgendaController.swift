import UIKit

final class AgendaController: BaseController {
    
    private let tableView = UITableView()
    private let addAimButton = UIButton()
    private var aims: [Aim] = []
    private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refetchData()
        reloadTableView()
    }
    
}

// MARK: - Support
extension AgendaController {
    private func refetchData() {
        Aim.fetchAims(aims: &aims, context: context)
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func addRow() {
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: aims.count - 1, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
    
    private func deleteRow(row: Int) {
        tableView.beginUpdates()
        tableView.deleteRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
}

// MARK: - UI
extension AgendaController {
    private func setUI() {
        setAddAimButton()
        setTableView()
    }
    
    private func setTableView() {
        view.addSubview(tableView)
        setTableViewPosition()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AimCell.self, forCellReuseIdentifier: Resources.AgendaController.AimCell.cellIdentifier)
        tableView.backgroundColor = Resources.Common.Colors.backgroundCard
        tableView.layer.cornerRadius = Resources.Common.Sizes.cornerRadius20
        

    }
    
    private func setAddAimButton() {
        view.addSubview(addAimButton)
        
        Resources.Common.setButton(button: addAimButton, image: nil, backgroundColor: Resources.Common.Colors.green, setPosition: setAddAimButtonPosition)
        addAimButton.setTitle("Aim +", for: .normal)
        addAimButton.addTarget(self, action: #selector(tapAddAim), for: .touchUpInside)
        
        setAddAimButtonPosition()
    }
    
}


// MARK: - Delegates
extension AgendaController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        aims.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Resources.AgendaController.AimCell.cellIdentifier, for: indexPath) as! AimCell
        let aimItem = aims[indexPath.row]
        
        cell.setAimCell(aim: aimItem)
        cell.selectionStyle = .none
        cell.separatorInset = .zero
        
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Aim.deleteAim(context: context, aimToRemove: aims[indexPath.row])
            Aim.saveContext(context: context)
            refetchData()
            deleteRow(row: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - Actions
extension AgendaController {
    @objc func tapAddAim() {
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .alert)
        
        alert.addTextField()
        
        alert.setValue(Resources.Common.returnStringWithAttributes(title: "Aim title"), forKey: "attributedTitle")
        
        let submitButton = UIAlertAction(title: "Yep", style: .default) { (action) in
            let aimTitleTextField = alert.textFields![0].text
            
            AgendaModel.createNewAim(context: self.context, aimTitle: aimTitleTextField!)
            self.refetchData()
            self.addRow()
        }
        
        alert.addAction(submitButton)
        
        self.present(alert, animated: true)
    }
}

// MARK: - Position
extension AgendaController {
    private func setAddAimButtonPosition() {
        addAimButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addAimButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addAimButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            addAimButton.widthAnchor.constraint(equalToConstant: 90),
            addAimButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setTableViewPosition() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: addAimButton.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
}
