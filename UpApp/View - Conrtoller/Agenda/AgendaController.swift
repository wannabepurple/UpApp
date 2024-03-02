import UIKit

class AgendaController: BaseController {
    override func viewDidLoad() {
        super.viewDidLoad()
        Resources.Common.setControllerAppearance(vc: self, title: Resources.TabBar.Titles.agenda)
    }
}
