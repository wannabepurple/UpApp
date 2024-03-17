import UIKit

enum Resources {
    
    enum Common {
        enum Colors {
            static let backgroundCard = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            static let backgroundGray = #colorLiteral(red: 0.9206777215, green: 0.9245578647, blue: 0.9244892001, alpha: 1)
            static let backgroundDark = #colorLiteral(red: 0.08416173607, green: 0.1026151553, blue: 0.1538609266, alpha: 1)
            static let black = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            static let green = #colorLiteral(red: 0.340277344, green: 0.9374753237, blue: 0.578148067, alpha: 1)
            static let purple = #colorLiteral(red: 0.5381102562, green: 0.2368915677, blue: 0.8926698565, alpha: 1)
            static let red = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        }
        
        enum Sizes {
            static let cornerRadius10: CGFloat = 10
            static let cornerRadius20: CGFloat = 20
            
            static let font40: CGFloat = 40
            static let font20: CGFloat = 20
        }
        
        enum Animations {
            static func changeButtonVisibility(button: UIButton, willHidden: Bool) {
                UIView.transition(with: button, duration: 0.2, options: .transitionCrossDissolve, animations: {
                    button.alpha = willHidden ? 0.0 : 1.0
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
        
        // MARK: Functions
        static func futura(size: CGFloat) -> UIFont {
            UIFont(name: "Futura-bold", size: size) ?? UIFont()
        }
                
        static func setControllerAppearance(vc: UIViewController, title: String) {
            vc.title = title
        }
        
        static func setButton(button: UIButton, 
                              size: CGFloat = 18,
                              title: String = "",
                              image: UIImage?,
                              backgroundColor: UIColor,
                              cornerRadius: CGFloat = Resources.Common.Sizes.cornerRadius10,
                              setPosition: () -> () = {}) {
            setPosition()
            button.backgroundColor = backgroundColor
            button.layer.masksToBounds = true
            button.layer.cornerRadius = cornerRadius
            button.titleLabel?.font = Resources.Common.futura(size: size)
            button.setTitleColor(Resources.Common.Colors.black, for: .normal)
            button.setTitle(title, for: .normal)
            button.tintColor = Resources.Common.Colors.black
            if let img = image {
                button.setImage(img, for: .normal)
            }
        }
        
        static func setLabel(label: UILabel, 
                             size: CGFloat = Resources.Common.Sizes.font20,
                             text: String = "",
                             backgroundColor: UIColor = Resources.Common.Colors.backgroundCard,
                             cornerRadius: CGFloat = Resources.Common.Sizes.cornerRadius10, 
                             setPosition: () -> () = {},
                             masksToBounds: Bool = false) {
            setPosition()
            label.backgroundColor = backgroundColor
            label.layer.cornerRadius = cornerRadius
            label.textColor = Resources.Common.Colors.backgroundDark
            label.layer.masksToBounds = masksToBounds
            label.font = Resources.Common.futura(size: size)
            label.text = text
            label.textAlignment = .center
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
        
        
    }
    
    enum MeController {
        enum PerkCell {
            static let cellIdentifier = "PerkCell"
            static let perkTitleFont: CGFloat = 20
            static let lvlFont: CGFloat = 15
            static let cellHeight: CGFloat = 300
            static let cellFootHeight: CGFloat = 20
        }
        
        enum SessionView {
            static let perkTitleFont: CGFloat = 40
            static let timerButtonFont: CGFloat = 30
            static let timerSide: CGFloat = 200
            static let timerCornerRadius: CGFloat = timerSide / 2
        }
    }
}
