import UIKit

// MARK: Project Hierarchy
// Tab Bar - is the root
// Controller - is subview of Tab Bar

enum Tabs: Int {
    case me
    case session
    case agenda
    case progress
}

final class TabBarController: UITabBarController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        configureTabBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTabBar() {
        tabBar.tintColor = Resources.TabBar.Colors.active
        tabBar.barTintColor = Resources.TabBar.Colors.inactive
        tabBar.backgroundColor = Resources.Common.Colors.backgroundDark
        tabBar.layer.masksToBounds = true
        
        // Making controllers
        let meController = MeController()
        let agendaController = AgendaController()
        let progressController = ProgressController()
                
        meController.tabBarItem = UITabBarItem(title: Resources.TabBar.Titles.me,
                                               image: Resources.TabBar.Images.me,
                                               tag: Tabs.me.rawValue)
        agendaController.tabBarItem = UITabBarItem(title: Resources.TabBar.Titles.agenda,
                                                   image: Resources.TabBar.Images.agenda,
                                                   tag: Tabs.agenda.rawValue)
        progressController.tabBarItem = UITabBarItem(title: Resources.TabBar.Titles.progress,
                                                     image: Resources.TabBar.Images.progress,
                                                     tag: Tabs.progress.rawValue)
        
        let attributes = [
            NSAttributedString.Key.font: Resources.Common.futura(size: 12) as Any,
            NSAttributedString.Key.foregroundColor: Resources.Common.Colors.backgroundCard
        ]
        
        meController.tabBarItem.setTitleTextAttributes(attributes, for: .normal)
        agendaController.tabBarItem.setTitleTextAttributes(attributes, for: .normal)
        progressController.tabBarItem.setTitleTextAttributes(attributes, for: .normal)
        
        // Nav bar example
        /*
        // Making navigation bar for each controllers
        let meNavigation = NavigationBarController(rootViewController: meController)
        
        // Custom tabBarItem for each navBar
        meNavigation.tabBarItem = UITabBarItem(title: Resources.TabBar.Titles.me,
                                               image: Resources.TabBar.Images.me,
                                               tag: Tabs.me.rawValue)
       
        // Changing font of tabBarItem titles
        let fontAttributes: [NSAttributedString.Key: Any] = [
            .font: Resources.Common.futura(size: 12) as Any
        ]
        meNavigation.tabBarItem.setTitleTextAttributes(fontAttributes, for: .normal)
        */
         
        // Adding controllers to tabBar
        setViewControllers([meController,
                            agendaController,
                            progressController], animated: false)
        
    }
}


