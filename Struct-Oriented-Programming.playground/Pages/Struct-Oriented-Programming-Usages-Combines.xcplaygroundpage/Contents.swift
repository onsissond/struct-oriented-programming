/*:
 # Struct oriented programming: Animations
 */
/*:
 ## Combine animations
 */

import UIKit

struct Animator<Target> {
    typealias Completion = (Bool) -> Void
    var animate: (Target, _ completion: Completion?) -> Void
}

extension Animator {
    static func merge(_ animators: Animator...) -> Animator {
        Animator { target, completion in
            var results = Array(repeating: false, count: animators.count)
            var completed = 0
            animators.enumerated().forEach { idx, animator in
                animator.animate(target) { result in
                    results[idx] = result
                    completed += 1
                    if completed == results.count {
                        completion?(results.reduce(true) { $0 && $1 })
                    }
                }
            }
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




extension Animator where Target == UIView {
    static let fadeIn = Animator { view, completion in
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: { view.alpha = 1.0 },
            completion: completion
        )
    }
    
    static func scale(x: CGFloat, y: CGFloat) -> Animator {
        Animator { view, completion in
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                options: .curveEaseOut,
                animations: {
                    view.transform = CGAffineTransform(scaleX: x, y: y)
                },
                completion: completion
            )
        }
    }
}



class MyViewController: UIViewController {}

extension MyViewController {
    func combineViewAnimations() {
        animate(view, animator: .merge(.fadeIn, .scale(x: 2, y: 2)))
    }
}






extension Animator where Target == CALayer {
    static func changeColor(
        _ color: UIColor,
        duration: TimeInterval = 0.5
    ) -> Animator {
        Animator { layer, completion in
            CATransaction.begin()
            let animation = CABasicAnimation(keyPath: "backgroundColor")
            animation.fromValue = layer.backgroundColor
            animation.toValue = color.cgColor
            animation.duration = duration
            CATransaction.setCompletionBlock {
                completion?(true)
            }
            layer.add(animation, forKey: "backgroundColor")
            CATransaction.commit()
            layer.backgroundColor = color.cgColor
        }
    }
}












/// Animator<UILayer> -> Animator<UIView>
extension Animator {
    func pullback<A>(
        _ f: @escaping (A) -> Target
    ) -> Animator<A> {
        Animator<A> { targetA, completion in
            self.animate(f(targetA), completion)
        }
    }
}


extension MyViewController {
    func combineAnimations() {
        animate(view, animator: .merge(
            Animator.fadeIn,
            Animator.scale(x: 2, y: 2),
            Animator.changeColor(.red).pullback(\.layer)
        ))
    }
}

//: [Next](@next)
