import UIKit

// MARK: Project Hierarchy
// Tab Bar - is the root
// Nav Bar - is subview of Tab Bar
// Controller - is subview of Nav Bar

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
        tabBar.backgroundColor = Resources.Common.Colors.backgroundWhite
        tabBar.layer.masksToBounds = true
        
        // Making controllers
        let meController = MeController()
        let sessionController = SessionController()
        let agendaController = AgendaController()
        let progressController = ProgressController()
        
        // Making navigation bar for each controllers
        let meNavigation = NavigationBarController(rootViewController: meController)
        let sessionNavigation = NavigationBarController(rootViewController: sessionController)
        let agendaNavigation = NavigationBarController(rootViewController: agendaController)
        let progressNavigation = NavigationBarController(rootViewController: progressController)

        // Custom tabBarItem for each navBar
        meNavigation.tabBarItem = UITabBarItem(title: Resources.TabBar.Titles.me,
                                                   image: Resources.TabBar.Images.me,
                                                   tag: Tabs.me.rawValue)
        sessionNavigation.tabBarItem = UITabBarItem(title: Resources.TabBar.Titles.session,
                                                   image: Resources.TabBar.Images.session,
                                                   tag: Tabs.session.rawValue)
        agendaNavigation.tabBarItem = UITabBarItem(title: Resources.TabBar.Titles.agenda,
                                                   image: Resources.TabBar.Images.agenda,
                                                   tag: Tabs.agenda.rawValue)
        progressNavigation.tabBarItem = UITabBarItem(title: Resources.TabBar.Titles.progress,
                                                   image: Resources.TabBar.Images.progress,
                                                   tag: Tabs.progress.rawValue)

        // Changing font of tabBarItem titles
        let fontAttributes: [NSAttributedString.Key: Any] = [
            .font: Resources.Common.futura(size: 12) as Any
        ]
        meNavigation.tabBarItem.setTitleTextAttributes(fontAttributes, for: .normal)
        sessionNavigation.tabBarItem.setTitleTextAttributes(fontAttributes, for: .normal)
        agendaNavigation.tabBarItem.setTitleTextAttributes(fontAttributes, for: .normal)
        progressNavigation.tabBarItem.setTitleTextAttributes(fontAttributes, for: .normal)
        
        // Adding navBars to tabBar
        setViewControllers([meNavigation,
                            sessionNavigation,
                            agendaNavigation,
                            progressNavigation], animated: false)
        
    }
}
