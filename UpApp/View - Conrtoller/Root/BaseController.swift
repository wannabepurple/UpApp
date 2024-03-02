import UIKit

class BaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBaseController()
    }
    
    func addViews() {}
    
    func layoutView() {}
    
    private func configureBaseController() {
        view.backgroundColor = Resources.Common.Colors.backgroundGray
    }
}


/*@objc  extension BaseController {
    func addViews() {}
    
    func layoutView() {}
    
    func configureBaseController() {
//        view.backgroundColor = Resources.Common.Colors.background
//        view.title =
//        Resources.Common.setControllerAppearance(vc: self, title: Resources.TabBar.Titles.settings)
    }
    
}
 */
