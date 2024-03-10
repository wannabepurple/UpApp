import UIKit

enum Resources {
    
    enum Common {
        enum Colors {
            static let backgroundCard = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            static let backgroundGray = #colorLiteral(red: 0.9206777215, green: 0.9245578647, blue: 0.9244892001, alpha: 1)
            static let backgroundDark = #colorLiteral(red: 0.08416173607, green: 0.1026151553, blue: 0.1538609266, alpha: 1)
            static let green = #colorLiteral(red: 0.340277344, green: 0.9374753237, blue: 0.578148067, alpha: 1)
            static let purple = #colorLiteral(red: 0.5381102562, green: 0.2368915677, blue: 0.8926698565, alpha: 1)
            static let red = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        }
        
        enum Sizes {
            static let cornerRadius10: CGFloat = 10
            static let cornerRadius20: CGFloat = 20
        }
        
        // MARK: Functions
        static func futura(size: CGFloat) -> UIFont {
            UIFont(name: "Futura-bold", size: size) ?? UIFont()
        }
                
        static func setControllerAppearance(vc: UIViewController, title: String) {
            vc.title = title
        }
    }
    
    enum TabBar {
        enum Colors {
            static let active = #colorLiteral(red: 0.340277344, green: 0.9374753237, blue: 0.578148067, alpha: 1)
            static let inactive = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
        enum Titles {
            static let me = "Me"
            static let session = "Session"
            static let agenda = "Agenda"
            static let progress = "Progress"
        }
        
        enum Images {
            static let me = UIImage(named: "me")
            static let session = UIImage(named: "session")
            static let agenda = UIImage(named: "agenda")
            static let progress = UIImage(named: "progress")
        }
    }
    
    enum SessionController {
        enum Images {
            static let bin = UIImage(named: "bin")
        }
        
        enum Animations {
            static func changeButtonVisibility(button: UIButton, willHidden: Bool) {
                UIView.transition(with: button, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    button.isHidden = willHidden
                }, completion: nil)
            }
            
            static func highlightTextFieldPlaceholder(textField: UITextField) {
                UIView.transition(with: textField, duration: 0.5) {
                    textField.backgroundColor = Resources.Common.Colors.purple
                }
                UIView.transition(with: textField, duration: 0.5) {
                    textField.backgroundColor = nil
                }
            }
        }
    }
    
    enum MeController {
        enum PerkCell {
            static let cellIdentifier = "PerkCell"
            static let perkTitleFont: CGFloat = 20
            static let lvlFont: CGFloat = 15
        }
    }
}
