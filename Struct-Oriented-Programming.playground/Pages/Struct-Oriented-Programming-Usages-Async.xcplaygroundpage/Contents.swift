/*:
 # Struct oriented programming: Animations
 */
/*:
 ## Async animations
 */

import UIKit
/*:
 ### Protocol oriented way
*/
protocol AnimatorProtocol {
    func animate(completion: ((Bool) -> Void)?)
}

extension UIView: AnimatorProtocol {
    func animate(completion: ((Bool) -> Void)?) {
        UIView.animate(
            withDuration: 5,
            delay: 0,
            options: [],
            animations: { self.alpha = 0.0 },
            completion: completion
        )
    }
}



/*:
 ### Struct oriented way
*/
struct Animator<Target> {
    typealias Completion = (Bool) -> Void
    var animate: (Target, _ completion: Completion?) -> Void
}

class MyViewController: UIViewController {}

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
        params: UIViewAnimationParams
    ) -> Animator {
        Animator { view, completion in
            UIView.animate(
                withDuration: params.duration,
                delay: params.delay,
                options: params.options,
                animations: { view.alpha = 0.0 },
                completion: completion
            )
        }
    }
}

extension UIViewController {
    func animate<Target>(
        _ target: Target,
        animator: Animator<Target>,
        completion: ((Bool) -> Void)? = nil
    ) {
        animator.animate(target, completion)
    }
}

extension MyViewController {
    func hideViewWithParamsWithCompletion() {
        animate(view, animator: .fadeOut(params: .default)) { _ in
            print("Animation is finished")
        }
    }
}

//: [Next](@next)
