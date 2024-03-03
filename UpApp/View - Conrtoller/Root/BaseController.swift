import UIKit

class BaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBaseController()
    }
    
    private func configureBaseController() {
        view.backgroundColor = Resources.Common.Colors.backgroundGray
    }
}
