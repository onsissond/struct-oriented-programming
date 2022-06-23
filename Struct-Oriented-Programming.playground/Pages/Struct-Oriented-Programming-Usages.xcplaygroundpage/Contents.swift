/*:
 # Struct oriented programming: Animations
 */
import UIKit
/*:
 ### Protocol oriented way
*/
protocol AnimatorProtocol {
    func animate()
}

extension UIView: AnimatorProtocol {
    func animate() {
        UIView.animate(
            withDuration: 5,
            delay: 0,
            options: [],
            animations: { self.alpha = 0.0 },
            completion: nil
        )
    }
}


/*:
 ### Struct oriented way
*/
struct Animator<Target> {
    var animate: (Target) -> Void
}

extension UIViewController {
    func animate<Target>(_ target: Target, animator: Animator<Target>) {
        animator.animate(target)
    }
}






/*:
 ### Fade out
*/
extension Animator where Target == UIView {
    static let fadeOut = Animator { view in
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: { view.alpha = 0.0 },
            completion: nil
        )
    }
}

class MyViewController: UIViewController {}
extension MyViewController {
    func hideView() {
        animate(self.view, animator: .fadeOut)
    }
}



/*:
 ### Fade in
*/
extension Animator where Target == UIView {
    static let fadeIn = Animator { view in
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: { view.alpha = 1.0 },
            completion: nil
        )
    }
}

extension MyViewController {
    func showView() {
        animate(self.view, animator: .fadeIn)
    }
}



/*:
 ### Add parameters
*/
struct UIViewAnimationParams {
    var duration: TimeInterval
    var delay: TimeInterval = 0
    var options: UIView.AnimationOptions = []

    static let `default` = UIViewAnimationParams(
        duration: 0.5,
        delay: 0,
        options: .curveEaseOut
    )
}

extension Animator where Target == UIView {
    static func fadeOut(
        _ params: UIViewAnimationParams
    ) -> Animator {
        Animator { view in
            UIView.animate(
                withDuration: params.duration,
                delay: params.delay,
                options: params.options,
                animations: { view.alpha = 0.0 },
                completion: nil
            )
        }
    }

    static func fadeOut(
        duration: TimeInterval,
        delay: TimeInterval = 0,
        options: UIView.AnimationOptions = []
    ) -> Animator {
        self.fadeOut(UIViewAnimationParams(
            duration: duration,
            delay: delay,
            options: options
        ))
    }
}

extension MyViewController {
    func hideViewWithParams() {
        animate(self.view, animator: .fadeOut(.default))
        animate(self.view, animator: .fadeOut(.init(duration: 10)))
        animate(self.view, animator: .fadeOut(duration: 10))
    }
}





/*:
 ### Layer confirmation
*/
extension Animator where Target == CALayer {
    static func changeColor(
        _ color: UIColor,
        duration: TimeInterval = 0.5
    ) -> Animator {
        Animator { layer in
            let animation = CABasicAnimation(keyPath: "backgroundColor")
            animation.fromValue = layer.backgroundColor
            animation.toValue = color.cgColor
            animation.duration = duration
            layer.add(animation, forKey: "backgroundColor")
            layer.backgroundColor = color.cgColor
        }
    }
}









extension MyViewController {
    func updateLayerBackground() {
        animate(view, animator: .fadeIn)
        animate(view.layer, animator: .changeColor(.red))
    }
}

//: [Next](@next)
