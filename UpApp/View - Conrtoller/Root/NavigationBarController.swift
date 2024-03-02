import UIKit

final class NavigationBarController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        view.backgroundColor = Resources.Common.Colors.backgroundWhite
        navigationBar.isTranslucent = false
        navigationBar.standardAppearance.titleTextAttributes = [
            .foregroundColor: Resources.NavBar.Colors.titleColor,
            .font: Resources.Common.futura(size: 20)]
    }
}
