import UIKit
import CoreData

class ProgressController: BaseController {
   
    private let aimsLabel = UILabel()
    private var aims: AimStat?
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AimStat.fetchStat(stats: &aims, context: context)
        updateCompletedAimsLabel()
    }
    
}

// MARK: - UI
extension ProgressController {
    private func setUI() {
        setCompletedAimsLabel()
    }
    
    private func setCompletedAimsLabel() {
        view.addSubview(aimsLabel)
        aimsLabel.backgroundColor = Resources.Common.Colors.purple
        setCompletedAimsLabelPosition()
        Resources.Common.setLabel(label: aimsLabel,
                                  backgroundColor: Resources.Common.Colors.green,
                                  setPosition: setCompletedAimsLabelPosition)
    }
    
    private func updateCompletedAimsLabel() {
        guard let aims = aims else { return }
        aimsLabel.text = String(aims.completedAims)
    }
    
}

// MARK: - Position
extension ProgressController {
    private func setCompletedAimsLabelPosition() {
        aimsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            aimsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            aimsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
