import UIKit

class MeController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Resources.Common.setControllerAppearance(vc: self, title: Resources.TabBar.Titles.me)
        
    }

}
