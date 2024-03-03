import UIKit

enum Resources {
    
    enum Common {
        enum Colors {
            static let backgroundWhite = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            static let backgroundGray = #colorLiteral(red: 0.9206777215, green: 0.9245578647, blue: 0.9244892001, alpha: 1)
            static let green = #colorLiteral(red: 0.4626408815, green: 0.7452270389, blue: 0.233566016, alpha: 1)
            static let yellow = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            static let red = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        }
        
        enum Sizes {
            static let cornerRadius: CGFloat = 10
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
            static let active = #colorLiteral(red: 0.4626408815, green: 0.7452270389, blue: 0.233566016, alpha: 1)
            static let inactive = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
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
    
    enum NavBar {
        enum Colors {
            static let titleColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
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
                    textField.backgroundColor = Resources.Common.Colors.yellow
                }
                UIView.transition(with: textField, duration: 0.5) {
                    textField.backgroundColor = nil
                }
            }
            
        }
    }
}
