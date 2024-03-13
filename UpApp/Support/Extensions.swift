import UIKit

extension UITextField {
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: center.x - 10, y: center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: center.x + 10, y: center.y))
        layer.add(animation, forKey: "position")
    }
}

// ADDME: empty string
extension String {
    subscript(index: Int) -> Character {
        guard index >= 0 && index < self.count else {
            fatalError("Index \(index) is out of bounds for string with \(count) characters.")
        }
        return self[self.index(self.startIndex, offsetBy: index)]
    }
}

