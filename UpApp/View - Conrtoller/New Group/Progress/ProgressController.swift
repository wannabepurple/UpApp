import UIKit

class ProgressController: BaseController {
   
    private let completedAimsLabel = UILabel()
//    private var completedAims: AimStat?
//    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        completedAims = AimStat(context: context)
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        AimStat.fetchStat(stats: &completedAims!, context: context)
    }
    
}

// MARK: - UI
extension ProgressController {
    private func setUI() {
        setCompletedAimsLabel()
    }
    
    private func setCompletedAimsLabel() {
        view.addSubview(completedAimsLabel)
//        completedAimsLabel.text = String(completedAims!.completedAims)
//        Resources.Common.setLabel(label: completedAimsLabel,
//                                  text: String(completedAims!.completedAims),
//                                  backgroundColor: Resources.Common.Colors.purple,
//                                  setPosition: setCompletedAimsLabelPosition)
    }
    
}

// MARK: - Position
extension ProgressController {
    private func setCompletedAimsLabelPosition() {
        completedAimsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            completedAimsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            completedAimsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
