/*:
 # Example of usages from Bolt
*/
import UIKit

struct ViewStyle<V> {
    let apply: (V) -> Void
}

extension ViewStyle {
    func with(_ style: ViewStyle) -> ViewStyle {
        ViewStyle<V> {
            self.apply($0)
            style.apply($0)
        }
    }
}





protocol Stylable {}

extension Stylable {
    func apply(_ style: ViewStyle<Self>) {
        style.apply(self)
    }
}

extension UIView: Stylable {}
extension CALayer: Stylable {}







extension ViewStyle where V: UIButton {
    static var link: ViewStyle<V> {
        ViewStyle<V> {
            $0.backgroundColor = .white
            $0.setTitleColor(UIColor(hex: 0x249E64), for: .normal)
            $0.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        }
    }
}

extension ViewStyle where V: UIView {
    static func cornerRadius(_ value: CGFloat) -> ViewStyle<V> {
        ViewStyle<V> {
            $0.layer.cornerRadius = value
        }
    }
}







let button = UIButton(
    frame: CGRect(origin: .init(x: 10, y: 200), size: CGSize(width: 300, height: 50))
)
button.apply(.link)
button.setTitle("Tap me", for: .normal)











import PlaygroundSupport

let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 325, height: 700)))
view.backgroundColor = .red
view.addSubview(button)
PlaygroundPage.current.liveView = view










extension ViewStyle where V: CALayer {
    static func shadow(style: ShadowStyle) -> ViewStyle<V> {
        ViewStyle<V> {
            $0.shadowColor = style.color.cgColor
            $0.shadowOffset = style.offset
            $0.shadowOpacity = style.opacity
            $0.shadowRadius = style.radius
        }
    }
}

button.layer.apply(.shadow(style: .default))



extension ViewStyle where V: UIButton {
    static var roundedLink: ViewStyle<UIButton> { .link.with(.cornerRadius(10))
    }
}

button.apply(.roundedLink)
